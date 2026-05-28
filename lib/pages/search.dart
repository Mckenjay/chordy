import 'package:chordy/core/styles/styles.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  bool isSong = true;

  @override
  void initState() {
    super.initState();
    searchController.addListener(() { setState(() {}); });
  }

  @override
  void dispose() { searchController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: c.surface,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_rounded)),
        title: Container(
          height: 42,
          decoration: BoxDecoration(
            color: c.surfaceLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: c.border.withValues(alpha: 0.4)),
          ),
          child: TextField(
            controller: searchController,
            autofocus: true,
            style: TextStyle(color: c.textPrimary, fontSize: 15),
            decoration: InputDecoration(
              hintText: isSong ? 'Search songs...' : 'Search library...',
              hintStyle: TextStyle(color: c.textMuted, fontSize: 15),
              border: InputBorder.none, enabledBorder: InputBorder.none, focusedBorder: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              prefixIcon: Icon(Icons.search_rounded, color: c.textMuted, size: 20),
              suffixIcon: searchController.text.isNotEmpty
                  ? IconButton(onPressed: () => searchController.clear(), icon: Icon(Icons.close_rounded, color: c.textSecondary, size: 18))
                  : null,
              filled: false,
            ),
            onChanged: (value) {
              if (isSong) {} else {}
            },
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: isSong ? AppColors.primaryIndigo.withValues(alpha: 0.15) : c.surfaceLight,
              borderRadius: BorderRadius.circular(10),
            ),
            child: IconButton(
              onPressed: () => setState(() { isSong = !isSong; }),
              tooltip: isSong ? 'Searching songs' : 'Searching library',
              icon: Icon(
                isSong ? Icons.music_note_rounded : Icons.library_music_rounded,
                color: isSong ? AppColors.primaryIndigo : c.textMuted, size: 20,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_rounded, size: 56, color: c.textMuted.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            Text(
              isSong ? 'Search for songs' : 'Search your library',
              style: TextStyle(color: c.textMuted, fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}