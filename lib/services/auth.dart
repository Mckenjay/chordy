import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn signIn = GoogleSignIn.instance;
  bool isGoogleSignInInitialized = false;

  AuthService() {
    initializeGoogleSignIn();
  }

  Future<void> initializeGoogleSignIn() async {
    try {
      await signIn.initialize(clientId: kIsWeb ? dotenv.env['GOOGLE_CLIENT_ID'] : null);
      isGoogleSignInInitialized = true;
    } catch (e) {
      print('Failed to initialize Google Sign-In: $e');
    }
  }

  Future<void> ensureGoogleSignInInitialized() async {
    if (!isGoogleSignInInitialized) await initializeGoogleSignIn();
  }
 }