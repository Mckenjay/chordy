import 'package:chordy/models/song_model.dart';
import 'package:chordy/services/song_service.dart';
import 'package:custom_flutter_chord/custom_flutter_chord.dart';
import 'package:flutter/material.dart';

class LyricsChordsPage extends StatelessWidget {
  final SongModel songData;
  const LyricsChordsPage({super.key, required this.songData});

  @override
  Widget build(BuildContext context) {
    SongService songService = SongService();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(songData.title),
        actions: [
          PopupMenuButton(
            itemBuilder:(BuildContext context) {
              return [
                PopupMenuItem(
                  value: const Text('Delete'),
                  child: const Text('Delete'),
                  onTap: () async {
                    await songService.deleteSong(songData.id.toString());

                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Song deleted successfully!')),
                    );
                    Navigator.pop(context);
                  },
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          LyricsRenderer(
            lyrics: songData.lyrics,
            textStyle: TextStyle(fontSize: 18, color: Colors.black),
            chordStyle: TextStyle(fontSize: 20, color: Colors.green),
            widgetPadding: 100,
            onTapChord: (String chord) {},
            transposeIncrement: 0,
            scrollSpeed: 0,
            showChord: true,
            showText: true,
            fixedChordSpace: 15,
            underlineChordSyllables: false,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Edit',
        child: Icon(Icons.edit, color: Colors.blue),
        onPressed: () {}
      ),
    );
  }
}