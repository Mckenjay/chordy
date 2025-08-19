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
      body: Center(child: Text('Lyrics'),),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Edit',
        child: Icon(Icons.edit, color: Colors.blue),
        onPressed: () {}
      ),
    );
  }
}