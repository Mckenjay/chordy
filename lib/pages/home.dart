import 'package:chordy/models/song_model.dart';
import 'package:chordy/pages/appbar_actions.dart';
import 'package:chordy/services/song_service.dart';
import 'package:flutter/material.dart';
import 'package:chordy/pages/lyrics_chords.dart';

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
        title: const Text("Chordy"),
        actions: const [AppBarActions()],
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
              return ListTile(
                leading: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Icon(Icons.lyrics_outlined, color: Colors.black),
                ),
                title: Text(song.title, style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text(song.artist),
                hoverColor: Colors.grey[300],
                // shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                trailing: IconButton(
                  onPressed:  (){
                    // showBottomSheet(context: context, builder: (_) => AlertDialog());
                  }, 
                  icon: const Icon(Icons.more_vert_outlined)
                ),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LyricsChordsPage(songData: song))),
              );
            },
          );
        }
      ),
    );
  }
}