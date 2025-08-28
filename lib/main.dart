import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chordy/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:chordy/pages/home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
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
        textTheme: GoogleFonts.robotoTextTheme(),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 71, 58, 183)),
      ),
      home: const HomePage()
    );
  }
}