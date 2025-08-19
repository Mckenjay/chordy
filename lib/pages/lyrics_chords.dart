import 'package:custom_flutter_chord/custom_flutter_chord.dart';
import 'package:flutter/material.dart';

class LyricsChordsPage extends StatefulWidget {
  const LyricsChordsPage({super.key});

  @override
  State<LyricsChordsPage> createState() => _LyricsChordsPageState();
}

class _LyricsChordsPageState extends State<LyricsChordsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Song Title'),
        actions: [
          PopupMenuButton(
            itemBuilder:(BuildContext context) {
              return [
                PopupMenuItem(
                  value: const Text('Delete'),
                  child: const Text('Delete'),
                  onTap: () {},
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          LyricsRenderer(
            lyrics: '''
              [C]Give me Freedom, [F]Give me fire
              [Am] Give me reason, [G]Take me higher
              ''',
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