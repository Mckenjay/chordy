import 'package:chordy/core/styles/styles.dart';
import 'package:chordy/models/song_model.dart';
import 'package:chordy/services/song.dart';
import 'package:flutter/material.dart';

class EditSong extends StatefulWidget {
  final SongModel songData;
  const EditSong({super.key, required this.songData});

  @override
  State<EditSong> createState() => _EditSongState();
}

class _EditSongState extends State<EditSong> {
  final SongService songService = SongService();
  TextEditingController titleController = TextEditingController();
  TextEditingController artistController = TextEditingController();
  TextEditingController lyricsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selectedKey = defaultMusicalKey;
  bool isLoading = false;

  @override
  initState() {
    super.initState();
    titleController = TextEditingController(text: widget.songData.title);
    artistController = TextEditingController(text: widget.songData.artist);
    lyricsController = TextEditingController(text: widget.songData.lyrics);
    selectedKey = normalizeMusicalKey(widget.songData.key) ?? defaultMusicalKey;
  }

  @override
  void dispose() {
    titleController.dispose();
    artistController.dispose();
    lyricsController.dispose();
    super.dispose();
  }

  Widget _sectionHeader(String title) {
    final c = context.colors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 20,
            decoration: BoxDecoration(
              gradient: AppGradients.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: c.textSecondary,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Edit Song'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHeader('Song Details'),
                Text('Title', style: appLabelStyle(context)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: titleController,
                  style: TextStyle(color: c.textPrimary),
                  decoration: appInputDecoration(
                    context,
                  ).copyWith(hintText: 'Enter song title'),
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Please enter a title'
                      : null,
                ),
                const SizedBox(height: 16),
                Text('Artist', style: appLabelStyle(context)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: artistController,
                  style: TextStyle(color: c.textPrimary),
                  decoration: appInputDecoration(
                    context,
                  ).copyWith(hintText: 'Enter artist name'),
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Please enter an artist'
                      : null,
                ),
                const SizedBox(height: 16),
                Text('Original Key', style: appLabelStyle(context)),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  initialValue: selectedKey,
                  dropdownColor: c.surface,
                  style: TextStyle(color: c.textPrimary, fontSize: 15),
                  decoration: appInputDecoration(
                    context,
                  ).copyWith(hintText: 'Select original key'),
                  items: musicalKeys
                      .map(
                        (key) => DropdownMenuItem<String>(
                          value: key,
                          child: Text(key),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedKey = value ?? defaultMusicalKey;
                    });
                  },
                ),
                const SizedBox(height: 24),
                _sectionHeader('Lyrics & Chords'),
                TextFormField(
                  controller: lyricsController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 15,
                  style: TextStyle(
                    color: c.textPrimary,
                    fontFamily: 'monospace',
                    fontSize: 14,
                    height: 1.6,
                  ),
                  decoration: appInputDecoration(context).copyWith(
                    hintText: 'Write your lyrics with chord annotations...',
                  ),
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Please write the lyrics'
                      : null,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: AppGradients.primary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryIndigo.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FloatingActionButton(
          tooltip: 'Update',
          backgroundColor: Colors.transparent,
          elevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
          onPressed: !isLoading
              ? () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    SongModel song = SongModel(
                      id: widget.songData.id,
                      title: titleController.text,
                      artist: artistController.text,
                      key: selectedKey,
                      lyrics: lyricsController.text,
                    );
                    await songService.updateSong(song);
                    if (!context.mounted) return;
                    setState(() {
                      isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Song updated successfully!'),
                      ),
                    );
                    Navigator.pop(context, song);
                  }
                }
              : null,
          child: !isLoading
              ? const Icon(Icons.check_rounded, color: Colors.white)
              : const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                ),
        ),
      ),
    );
  }
}
