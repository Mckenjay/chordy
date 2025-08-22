import 'package:chordy/models/song_model.dart';
import 'package:chordy/pages/edit_song.dart';
import 'package:chordy/services/song_service.dart';
import 'package:custom_flutter_chord/custom_flutter_chord.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LyricsChordsPage extends StatefulWidget {
  final SongModel songData;
  const LyricsChordsPage({super.key, required this.songData});

  @override
  State<LyricsChordsPage> createState() => _LyricsChordsPageState();
}

class _LyricsChordsPageState extends State<LyricsChordsPage> {
  late SongModel _songData;
  int transposeIncrement = 0;
  int scrollSpeed = 0;
  bool isShowChord = true;
  bool isShowText = true;

  @override
  initState() {
    super.initState();
    _songData = widget.songData;
  }

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
        title: Text(_songData.title),
        actions: [
          PopupMenuButton(
            itemBuilder:(BuildContext context) {
              return [
                PopupMenuItem(
                  value: const Text('Delete'),
                  child: const Text('Delete'),
                  onTap: () async {
                    await songService.deleteSong(_songData.id.toString());

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
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              color: Colors.black,
              child: LyricsRenderer(
                lyrics: _songData.lyrics,
                textStyle: TextStyle(fontSize: 18, color: Colors.white),
                chordStyle: TextStyle(fontSize: 20, color: Colors.green),
                widgetPadding: 24,
                lineHeight: 4,
                onTapChord: (String chord) {},
                transposeIncrement: transposeIncrement,
                scrollSpeed: scrollSpeed,
                showChord: isShowChord,
                showText: isShowText,
                minorScale: false,
                horizontalAlignment: CrossAxisAlignment.start,
                fixedChordSpace: 15,
              ),      
            )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Edit',
        child: Icon(Icons.edit, color: Colors.blue),
        onPressed: () async {
          final updatedSongData = await Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => EditSong(songData: _songData))
          );

          if (updatedSongData != null) {
            setState(() {
              _songData = updatedSongData;
            });
          } 
        }
      ),
      bottomNavigationBar: Container(
        color: Colors.black26,
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          transposeIncrement--;
                        });
                      }, 
                      child: Text('-')
                    ),
                    SizedBox(width: 5,),
                    Text('$transposeIncrement'),
                    SizedBox(width: 5,),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          transposeIncrement++;
                        });
                      }, 
                      child: Text('+')
                    ),
                  ],
                ),
                Text('Transpose'),
              ],
            ),
            // Column(
            //   mainAxisSize: MainAxisSize.min,
            //   children: [
            //     Row(
            //       children: [
            //         ElevatedButton(
            //           onPressed: scrollSpeed <= 0
            //             ? null
            //             : () {
            //             setState(() {
            //               scrollSpeed--;
            //             });
            //           }, 
            //           child: Text('-')
            //         ),
            //         SizedBox(width: 5,),
            //         Text('$scrollSpeed'),
            //         SizedBox(width: 5,),
            //         ElevatedButton(
            //           onPressed: () {
            //             setState(() {
            //               scrollSpeed++;
            //             });
            //           }, 
            //           child: Text('+')
            //         ),
            //       ],
            //     ),
            //     Text('Auto Scroll'),
            //   ],
            // ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CupertinoSwitch(
                      value: isShowChord, 
                      onChanged: (value) {
                        if (value == false && isShowText == false) {
                          setState(() {
                            isShowText = true;
                          });
                        }
                        setState(() {
                          isShowChord = value;
                        });
                      }
                    ),
                    SizedBox(width: 5,),
                  ],
                ),
                Text('Show Chord'),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CupertinoSwitch(
                      value: isShowText, 
                      onChanged: (value) {
                        if (value == false && isShowChord == false) {
                          setState(() {
                            isShowChord = true;
                          });
                        }
                        setState(() {
                          isShowText = value;
                        });
                      }
                    ),
                    SizedBox(width: 5,),
                  ],
                ),
                Text('Show Text'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}