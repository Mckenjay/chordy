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
      body: Center(child: Text('About Chordy'),),
    );
  }
}