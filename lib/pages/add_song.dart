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

  final inputDecoration = InputDecoration(
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: Colors.lightBlue,
        width: 2,
      )
    )
  );

  final textStyle = TextStyle(
    fontSize: 18, 
    fontWeight: FontWeight.bold, 
    letterSpacing: 1,
    color: Colors.black,
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Add Song'),
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

                !isLoading 
                  ? Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        minimumSize: WidgetStateProperty.all(Size(200, 50)),
                        backgroundColor: WidgetStatePropertyAll(Colors.blue)
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
                            SnackBar(content: Text('Song added successfully!')),
                          );

                          Navigator.pop(context);
                        }
                      },
                      child: Text('Submit', style: textStyle,)
                    ),
                  )
                  : Center(
                    child: CircularProgressIndicator(),
                  )
              ],
            ),
          )
        ),
      ),
    );
  }
}