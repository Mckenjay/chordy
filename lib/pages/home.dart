import 'package:chordy/models/song_model.dart';
import 'package:chordy/services/song_service.dart';
import 'package:flutter/material.dart';
import 'package:chordy/pages/lyrics_chords.dart';
import 'package:chordy/appbar_actions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final SongService songService = SongService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          const AppBarActions(),
        ],
        title: const Text("Chordy"),
      ),
      body: StreamBuilder(
        stream: songService.getSongsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) { 
            return const Center(child: CircularProgressIndicator()); 
          } 

          if (snapshot.hasError) { 
            return Center(child: Text("Error: ${snapshot.error}")); 
          } 
  
          if (!snapshot.hasData || snapshot.data!.isEmpty) { 
            return const Center(child: Text("No songs available")); 
          }

          return ListView.builder(
            padding: EdgeInsets.only(left: 10, right: 10),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              SongModel song = snapshot.data![index];
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.lyrics_outlined, color: Colors.black),
                  title: Text(song.title, style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(song.artist),
                  hoverColor: Colors.grey[300],
                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                  trailing: Icon(Icons.chevron_right, color: Colors.blue,),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LyricsChordsPage(songData: song,)));
                  },
                ),
              );
            },
          );
        }
      ),
    );
  }
}