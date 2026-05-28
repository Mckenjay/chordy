import 'package:chordy/core/styles/styles.dart';
import 'package:chordy/pages/appbar_actions.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
        actions: const [AppBarActions()],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80, height: 80,
              decoration: BoxDecoration(
                color: c.surfaceLight,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: c.border.withValues(alpha: 0.3)),
              ),
              child: Icon(Icons.library_music_outlined, color: c.textMuted, size: 40),
            ),
            const SizedBox(height: 20),
            Text('Your Library', style: TextStyle(color: c.textPrimary, fontSize: 20, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Text('Create collections to organize your songs', style: TextStyle(color: c.textMuted, fontSize: 14)),
          ],
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          gradient: AppGradients.primary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: AppColors.primaryIndigo.withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: FloatingActionButton(
          tooltip: 'Add',
          backgroundColor: Colors.transparent, elevation: 0, hoverElevation: 0, focusElevation: 0, highlightElevation: 0,
          onPressed: () {},
          child: const Icon(Icons.add_rounded, color: Colors.white),
        ),
      ),
    );
  }
}