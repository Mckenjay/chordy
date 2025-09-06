import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_web/web_only.dart' as web;

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn signIn = GoogleSignIn.instance;

  Future<Widget?> platformAwareSignIn() async {
    if (!signIn.supportsAuthenticate()) {
      if (kIsWeb) {
        // Use web-specific sign-in UI
        await signIn.initialize(clientId: dotenv.env['GOOGLE_CLIENT_ID']);
        return web.renderButton(configuration: web.GSIButtonConfiguration(theme: web.GSIButtonTheme.outline));
      } else {
        throw UnsupportedError('Platform not supported');
      }
    }
    return null;
    // return await signIn.authenticate(scopeHint: ['email']);
  }
}