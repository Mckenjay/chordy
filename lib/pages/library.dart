import 'package:chordy/pages/abouts.dart';
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
        actions: [
          IconButton(
            tooltip: 'Account',
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const Abouts())),
          ),
        ],
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