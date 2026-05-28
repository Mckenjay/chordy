import 'package:chordy/core/styles/styles.dart';
import 'package:chordy/models/song_model.dart';
import 'package:chordy/pages/appbar_actions.dart';
import 'package:chordy/services/song.dart';
import 'package:flutter/material.dart';
import 'package:chordy/pages/lyrics_chords.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SongService songService = SongService();

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 32, height: 32,
              decoration: BoxDecoration(gradient: AppGradients.primary, borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.music_note_rounded, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            const Text("Chordy"),
          ],
        ),
        actions: const [AppBarActions()],
      ),
      body: StreamBuilder(
        stream: songService.getSongsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(strokeWidth: 3, color: AppColors.primaryIndigo),
                  const SizedBox(height: 16),
                  Text('Loading songs...', style: TextStyle(color: c.textMuted, fontSize: 14)),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.error_outline_rounded, size: 56, color: AppColors.error.withValues(alpha: 0.7)),
                  const SizedBox(height: 12),
                  Text("Something went wrong", style: TextStyle(color: c.textPrimary, fontSize: 18, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 6),
                  Text("${snapshot.error}", style: TextStyle(color: c.textMuted, fontSize: 13), textAlign: TextAlign.center),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 80, height: 80,
                    decoration: BoxDecoration(gradient: AppGradients.primary, borderRadius: BorderRadius.circular(20)),
                    child: const Icon(Icons.music_off_rounded, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 20),
                  Text("No songs yet", style: TextStyle(color: c.textPrimary, fontSize: 20, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  Text("Add your first song to get started", style: TextStyle(color: c.textMuted, fontSize: 14)),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            itemCount: snapshot.data!.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(4, 8, 4, 12),
                  child: Row(
                    children: [
                      Text('All Songs', style: TextStyle(color: c.textSecondary, fontSize: 13, fontWeight: FontWeight.w600, letterSpacing: 0.8)),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: AppColors.primaryIndigo.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                        child: Text('${snapshot.data!.length}', style: const TextStyle(color: AppColors.primaryIndigo, fontSize: 12, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                );
              }
              final songIndex = index - 1;
              SongModel song = snapshot.data![songIndex];
              return _SongTile(song: song, index: songIndex, animationDelay: songIndex * 60);
            },
          );
        },
      ),
    );
  }
}

class _SongTile extends StatefulWidget {
  final SongModel song;
  final int index;
  final int animationDelay;

  const _SongTile({required this.song, required this.index, required this.animationDelay});

  @override
  State<_SongTile> createState() => _SongTileState();
}

class _SongTileState extends State<_SongTile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 400), vsync: this);
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    Future.delayed(Duration(milliseconds: widget.animationDelay), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              splashColor: AppColors.primaryIndigo.withValues(alpha: 0.1),
              highlightColor: AppColors.primaryIndigo.withValues(alpha: 0.05),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LyricsChordsPage(songData: widget.song))),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: AppDecorations.songCard(context),
                child: Row(
                  children: [
                    Container(
                      width: 50, height: 50,
                      decoration: BoxDecoration(
                        gradient: AppGradients.songTile(widget.index),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: AppGradients.songTile(widget.index).colors.first.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 3))],
                      ),
                      child: const Icon(Icons.music_note_rounded, color: Colors.white, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.song.title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: c.textPrimary, letterSpacing: 0.1), maxLines: 1, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 3),
                          Text(widget.song.artist, style: TextStyle(color: c.textSecondary, fontSize: 13), maxLines: 1, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    IconButton(onPressed: () {}, icon: Icon(Icons.more_horiz_rounded, color: c.textMuted, size: 22), splashRadius: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}