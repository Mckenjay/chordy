import 'package:chordy/core/styles/styles.dart';
import 'package:chordy/models/song_model.dart';
import 'package:chordy/services/song.dart';
import 'package:flutter/material.dart';

class AddSong extends StatefulWidget {
  const AddSong({super.key});

  @override
  State<AddSong> createState() => _AddSongState();
}

class _AddSongState extends State<AddSong> {
  final SongService songService = SongService();
  TextEditingController titleController = TextEditingController();
  TextEditingController artistController = TextEditingController();
  TextEditingController lyricsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selectedKey = defaultMusicalKey;
  bool isLoading = false;

  @override
  dispose() {
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
        title: const Text('Add Song'),
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
                    hintText:
                        'Write your lyrics with chord annotations...\n\nExample:\n[Am]Amazing [G]grace how [C]sweet the sound',
                  ),
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Please write the lyrics'
                      : null,
                ),
                const SizedBox(height: 24),
                !isLoading
                    ? Center(
                        child: Container(
                          width: 220,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: AppGradients.primary,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primaryIndigo.withValues(
                                  alpha: 0.4,
                                ),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              minimumSize: const Size(220, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  isLoading = true;
                                });
                                await songService.addSong(
                                  SongModel(
                                    title: titleController.text,
                                    artist: artistController.text,
                                    key: selectedKey,
                                    lyrics: lyricsController.text,
                                  ),
                                );
                                if (!context.mounted) return;
                                setState(() {
                                  isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Song added successfully!',
                                    ),
                                  ),
                                );
                                Navigator.pop(context);
                              }
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Add Song',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Center(
                        child: Container(
                          width: 220,
                          height: 50,
                          decoration: BoxDecoration(
                            gradient: AppGradients.primary,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Center(
                            child: SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              ),
                            ),
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
