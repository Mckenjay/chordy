import 'package:chordy/core/styles/styles.dart';
import 'package:chordy/models/song_model.dart';
import 'package:chordy/pages/edit_song.dart';
import 'package:chordy/services/song.dart';
import 'package:custom_flutter_chord/custom_flutter_chord.dart';
import 'package:flutter/material.dart';

class LyricsChordsPage extends StatefulWidget {
  final SongModel songData;

  const LyricsChordsPage({super.key, required this.songData});

  @override
  State<LyricsChordsPage> createState() => _LyricsChordsPageState();
}

class _LyricsChordsPageState extends State<LyricsChordsPage> {
  static const int _autoScrollSpeed = 10;

  final SongService _songService = SongService();
  late SongModel _songData;
  int transposeIncrement = 0;
  int scrollSpeed = 0;
  bool isShowChord = true;
  bool isShowText = true;

  late int _originalKeyIndex;
  late int _selectedKeyIndex;

  @override
  void initState() {
    super.initState();
    _songData = widget.songData;
    _originalKeyIndex = _resolveOriginalKeyIndex(_songData);
    _selectedKeyIndex = _originalKeyIndex;
  }

  int _resolveOriginalKeyIndex(SongModel song) {
    return musicalKeyIndex(song.key) ??
        _detectMetadataKeyIndex(song.lyrics) ??
        musicalKeyIndex(defaultMusicalKey)!;
  }

  int? _detectMetadataKeyIndex(String lyrics) {
    final keyPattern = RegExp(
      r'^\s*\{(?:key|k)\s*:\s*([^}]+)\}\s*$',
      caseSensitive: false,
      multiLine: true,
    );
    final match = keyPattern.firstMatch(lyrics);
    return musicalKeyIndex(match?.group(1));
  }

  String _filterLyricsForChordsOnly(String lyrics) {
    final chordPattern = RegExp(r'\[.*?\]');
    final sectionPattern = RegExp(r'/[^/\r\n]+/');
    final lines = lyrics.split('\n');
    final filtered = <String>[];
    bool lastWasEmpty = false;

    for (final line in lines) {
      final trimmed = line.trim();
      if (chordPattern.hasMatch(line) ||
          sectionPattern.hasMatch(line) ||
          trimmed.startsWith('{')) {
        filtered.add(line);
        lastWasEmpty = false;
      } else if (trimmed.isEmpty && !lastWasEmpty) {
        filtered.add('');
        lastWasEmpty = true;
      }
    }

    while (filtered.isNotEmpty && filtered.last.trim().isEmpty) {
      filtered.removeLast();
    }

    return filtered.join('\n');
  }

  void _onKeySelected(int keyIndex) {
    setState(() {
      _selectedKeyIndex = keyIndex % musicalKeys.length;
      transposeIncrement = (_selectedKeyIndex - _originalKeyIndex) % 12;
      if (transposeIncrement < 0) transposeIncrement += 12;
    });
  }

  void _changeKeyBy(int offset) {
    _onKeySelected((_selectedKeyIndex + offset) % musicalKeys.length);
  }

  void _setShowChord(bool value) {
    setState(() {
      if (!value && !isShowText) {
        isShowText = true;
      }
      isShowChord = value;
    });
  }

  void _setShowText(bool value) {
    setState(() {
      if (!value && !isShowChord) {
        isShowChord = true;
      }
      isShowText = value;
    });
  }

  void _toggleAutoScroll() {
    setState(() {
      scrollSpeed = scrollSpeed > 0 ? 0 : _autoScrollSpeed;
    });
  }

  Future<void> _openEditSong() async {
    final updatedSongData = await Navigator.push<SongModel>(
      context,
      MaterialPageRoute(builder: (context) => EditSong(songData: _songData)),
    );

    if (updatedSongData == null || !mounted) return;
    setState(() {
      _songData = updatedSongData;
      _originalKeyIndex = _resolveOriginalKeyIndex(_songData);
      _selectedKeyIndex = _originalKeyIndex;
      transposeIncrement = 0;
    });
  }

  Future<void> _deleteSong() async {
    final songId = _songData.id;
    if (songId == null) return;

    await _songService.deleteSong(songId);
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Song deleted successfully!')));
    Navigator.pop(context);
  }

  Future<void> _showKeyPicker() async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      backgroundColor: context.colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return _KeyPickerSheet(
          selectedKeyIndex: _selectedKeyIndex,
          originalKeyIndex: _originalKeyIndex,
          onKeySelected: (index) {
            Navigator.pop(context);
            _onKeySelected(index);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final displayLyrics = (!isShowText && isShowChord)
        ? _filterLyricsForChordsOnly(_songData.lyrics)
        : _songData.lyrics;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 58,
        titleSpacing: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _songData.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            Text(
              _songData.artist,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: c.textSecondary,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Edit',
            icon: Icon(Icons.edit_rounded, color: c.textSecondary),
            onPressed: _openEditSong,
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert_rounded, color: c.textSecondary),
            onSelected: (value) {
              if (value == 'delete') {
                _deleteSong();
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_outline_rounded,
                        color: AppColors.error,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Text('Delete', style: TextStyle(color: AppColors.error)),
                    ],
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: context.isDark
                ? [
                    const Color(0xFF0D1117),
                    const Color(0xFF0A0E14),
                    const Color(0xFF060A10),
                  ]
                : [c.background, c.surfaceLight, c.background],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          top: false,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
            child: LyricsRenderer(
              lyrics: displayLyrics,
              textStyle: TextStyle(
                fontSize: 19,
                height: 1.45,
                color: c.textPrimary,
                fontWeight: FontWeight.w500,
              ),
              chordStyle: TextStyle(
                fontSize: 21,
                height: 1.1,
                color: context.isDark
                    ? AppColors.chordGreen
                    : AppColors.primaryIndigo,
                fontWeight: FontWeight.w800,
              ),
              widgetPadding: 32,
              parentWidth: MediaQuery.sizeOf(context).width - 32,
              lineHeight: 10,
              onTapChord: (String chord) {},
              transposeIncrement: transposeIncrement,
              scrollSpeed: scrollSpeed,
              showChord: isShowChord,
              showText: isShowText,
              minorScale: false,
              horizontalAlignment: CrossAxisAlignment.start,
              fixedChordSpace: 20,
              scrollPhysics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              leadingWidget: const SizedBox(height: 4),
              trailingWidget: const SizedBox(height: 28),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _PerformanceControls(
        currentKey: musicalKeys[_selectedKeyIndex],
        originalKey: musicalKeys[_originalKeyIndex],
        scrollSpeed: scrollSpeed,
        showChord: isShowChord,
        showText: isShowText,
        onTransposeDown: () => _changeKeyBy(-1),
        onTransposeUp: () => _changeKeyBy(1),
        onKeyPressed: _showKeyPicker,
        onToggleChord: () => _setShowChord(!isShowChord),
        onToggleText: () => _setShowText(!isShowText),
        onToggleAutoScroll: _toggleAutoScroll,
      ),
    );
  }
}

class _PerformanceControls extends StatelessWidget {
  final String currentKey;
  final String originalKey;
  final int scrollSpeed;
  final bool showChord;
  final bool showText;
  final VoidCallback onTransposeDown;
  final VoidCallback onTransposeUp;
  final VoidCallback onKeyPressed;
  final VoidCallback onToggleChord;
  final VoidCallback onToggleText;
  final VoidCallback onToggleAutoScroll;

  const _PerformanceControls({
    required this.currentKey,
    required this.originalKey,
    required this.scrollSpeed,
    required this.showChord,
    required this.showText,
    required this.onTransposeDown,
    required this.onTransposeUp,
    required this.onKeyPressed,
    required this.onToggleChord,
    required this.onToggleText,
    required this.onToggleAutoScroll,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppDecorations.glassBar(context),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                _RoundControlButton(
                  icon: Icons.remove_rounded,
                  tooltip: 'Transpose down',
                  onPressed: onTransposeDown,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _KeyControlButton(
                    currentKey: currentKey,
                    originalKey: originalKey,
                    onPressed: onKeyPressed,
                  ),
                ),
                const SizedBox(width: 8),
                _RoundControlButton(
                  icon: Icons.add_rounded,
                  tooltip: 'Transpose up',
                  onPressed: onTransposeUp,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _ModeControlButton(
                    icon: Icons.music_note_rounded,
                    label: 'Chords',
                    selected: showChord,
                    onPressed: onToggleChord,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _ModeControlButton(
                    icon: Icons.short_text_rounded,
                    label: 'Lyrics',
                    selected: showText,
                    onPressed: onToggleText,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _ModeControlButton(
                    icon: Icons.swap_vert_rounded,
                    label: scrollSpeed > 0 ? 'Scroll' : 'Scroll',
                    selected: scrollSpeed > 0,
                    onPressed: onToggleAutoScroll,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundControlButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  const _RoundControlButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SizedBox(
      width: 44,
      height: 44,
      child: Tooltip(
        message: tooltip,
        child: Material(
          color: c.surfaceLight,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onPressed,
            child: Icon(icon, color: c.textPrimary, size: 24),
          ),
        ),
      ),
    );
  }
}

class _KeyControlButton extends StatelessWidget {
  final String currentKey;
  final String originalKey;
  final VoidCallback onPressed;

  const _KeyControlButton({
    required this.currentKey,
    required this.originalKey,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final subtitle = currentKey == originalKey
        ? 'Original key'
        : 'From $originalKey';

    return SizedBox(
      height: 44,
      child: Material(
        color: AppColors.primaryIndigo.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.tune_rounded,
                  color: AppColors.primaryIndigo,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Key $currentKey',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.primaryIndigo,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: c.textSecondary,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ModeControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onPressed;

  const _ModeControlButton({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return SizedBox(
      height: 40,
      child: Material(
        color: selected
            ? AppColors.primaryIndigo.withValues(alpha: 0.18)
            : c.surfaceLight,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: selected ? AppColors.primaryIndigo : c.textSecondary,
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: selected
                          ? AppColors.primaryIndigo
                          : c.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _KeyPickerSheet extends StatelessWidget {
  final int selectedKeyIndex;
  final int originalKeyIndex;
  final ValueChanged<int> onKeySelected;

  const _KeyPickerSheet({
    required this.selectedKeyIndex,
    required this.originalKeyIndex,
    required this.onKeySelected,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transpose',
              style: TextStyle(
                color: c.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Original key: ${musicalKeys[originalKeyIndex]}',
              style: TextStyle(
                color: c.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 14),
            LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = (constraints.maxWidth - 24) / 4;
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: List.generate(musicalKeys.length, (index) {
                    final isSelected = index == selectedKeyIndex;
                    final isOriginal = index == originalKeyIndex;
                    return SizedBox(
                      width: itemWidth,
                      height: 46,
                      child: _KeyChoiceButton(
                        label: musicalKeys[index],
                        selected: isSelected,
                        original: isOriginal,
                        onPressed: () => onKeySelected(index),
                      ),
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _KeyChoiceButton extends StatelessWidget {
  final String label;
  final bool selected;
  final bool original;
  final VoidCallback onPressed;

  const _KeyChoiceButton({
    required this.label,
    required this.selected,
    required this.original,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Material(
      color: selected ? AppColors.primaryIndigo : c.surfaceLight,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onPressed,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: original && !selected
                  ? AppColors.primaryIndigo.withValues(alpha: 0.6)
                  : Colors.transparent,
              width: 1.4,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : original
                    ? AppColors.primaryIndigo
                    : c.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
