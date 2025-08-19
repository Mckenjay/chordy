import 'package:flutter/material.dart';
import 'package:flutter_chords/pages/lyrics_chords.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_chords/appbar_actions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final songs = 30;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chordy',
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 71, 58, 183)),
      ),
      home: Scaffold(
        appBar: AppBar(
          actions: [
            AppBarActions(),
          ],
          title: const Text("Chordy"),
        ),
        body: ListView.builder(
          padding: EdgeInsets.only(left: 10, right: 10),
          itemCount: songs,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Icon(Icons.lyrics_outlined, color: Colors.black),
                title: Text('Song Lyric ${index+1}', style: TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text('Artist'),
                hoverColor: Colors.grey[300],
                shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                trailing: Icon(Icons.chevron_right, color: Colors.blue,),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LyricsChordsPage()));
                },
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add Song',
          child: Icon(Icons.add_outlined, color: Colors.blue),
          onPressed: () {}
        ),
      ),
    );
  }
}