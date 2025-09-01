import 'package:chordy/pages/appbar_actions.dart';
import 'package:flutter/material.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
        actions: const [AppBarActions()],
      ),
      body: const Center(child: Text('Library'),),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add',
        child: const Icon(Icons.add, color: Colors.blue),
        onPressed: () {}
      ),
    );
  }
}