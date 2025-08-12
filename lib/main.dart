import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_chords/firebase_options.dart';
import 'package:flutter_chords/appbar_actions.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chordy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 71, 58, 183)),
      ),
      home: Scaffold(
        appBar: AppBar(
          actions: [
            AppBarActions(),
          ],
          title: const Text("Chordy"),
        ),
        body: const Center(
          child: Text("Hello, Chordy!"),
        ),
      ),
    );
  }
}