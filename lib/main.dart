import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:chordy/firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:chordy/pages/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const HomePage());
}