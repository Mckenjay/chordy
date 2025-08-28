import 'package:chordy/core/styles/styles.dart';
import 'package:chordy/models/song_model.dart';
import 'package:chordy/services/song_service.dart';
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

  bool isLoading = false;

  @override
  dispose() {
    titleController.dispose();
    artistController.dispose();
    lyricsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Add Song'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Title', style: textStyle),
                const SizedBox(height: 6),
                TextFormField(
                  controller: titleController,
                  decoration: inputDecoration,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                const Text('Artist', style: textStyle),
                const SizedBox(height: 6),
                TextFormField(
                  controller: artistController,
                  decoration: inputDecoration,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an artist';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                const Text('Lyrics & Chords', style: textStyle),
                const SizedBox(height: 6),
                TextFormField(
                  controller: lyricsController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 20,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: Colors.lightBlue,
                        width: 2,
                      )
                    )
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please write the lyrics';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),

                !isLoading 
                  ? Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(Size(200, 50)),
                        backgroundColor: const WidgetStatePropertyAll(Colors.blue)
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
                              lyrics: lyricsController.text
                            )
                          );

                          if (!context.mounted) return;

                          setState(() {
                            isLoading = false;
                          });
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: const Text('Song added successfully!')),
                          );

                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Submit', style: textStyle,)
                    ),
                  )
                  : Center(
                    child: const CircularProgressIndicator(),
                  )
              ],
            ),
          )
        ),
      ),
    );
  }
}