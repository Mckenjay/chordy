import 'package:chordy/models/song_model.dart';
import 'package:chordy/services/song_service.dart';
import 'package:flutter/material.dart';
import 'package:chordy/core/styles/styles.dart';

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
  
  bool isLoading = false;

  @override
  initState() {
    super.initState();
    titleController = TextEditingController(text: widget.songData.title);
    artistController = TextEditingController(text: widget.songData.artist);
    lyricsController = TextEditingController(text: widget.songData.lyrics);
  }

  @override
  void dispose() {
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
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Edit Song'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title', style: textStyle),
                SizedBox(height: 6),
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
                SizedBox(height: 10),
                Text('Artist', style: textStyle),
                SizedBox(height: 6),
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
                SizedBox(height: 10),
                Text('Lyrics & Chords', style: textStyle),
                SizedBox(height: 6),
                TextFormField(
                  controller: lyricsController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  minLines: 10,
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
                SizedBox(height: 10),
              ],
            ),
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Update',
        onPressed: !isLoading ? () async {
          if (_formKey.currentState!.validate()) {
            setState(() {
              isLoading = true;
            });

            SongModel song = SongModel(
              id: widget.songData.id,
              title: titleController.text, 
              artist: artistController.text, 
              lyrics: lyricsController.text
            );

            await songService.updateSong(song);

            if (!context.mounted) return;

            setState(() {
              isLoading = false;
            });
            
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Song updated successfully!')),
            );

            Navigator.pop(context, song);
          }
        } : null,
        child:
          !isLoading 
            ? Icon(Icons.update)
            : CircularProgressIndicator(),
      ),
    );
  }
}