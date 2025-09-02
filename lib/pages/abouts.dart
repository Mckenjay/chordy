import 'package:flutter/material.dart';

class Abouts extends StatelessWidget {
  const Abouts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }
        ),
        title: Text('About'),
      ),
      body: Center(
        child: Column(
          children: [
            const CircleAvatar(
              radius: 70,
              foregroundImage: NetworkImage("https://avatars.githubusercontent.com/Mckenjay"),
            ),
            const SizedBox(height: 4,),
            const Text('CHORDY', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
            Chip(
              label: const Text('0.0.1'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            ),
            const SizedBox(height: 4,),
            const Text('Mckenjay', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}