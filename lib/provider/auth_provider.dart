import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_breedersweb/navigator.dart';
import 'package:flutter_application_breedersweb/view/auth/login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// ignore_for_file: use_build_context_synchronously


class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '904534866902-212voio9pnkt287nfgnioicdveo7i04m.apps.googleusercontent.com',
  );
  User? _user;

  User? get user => _user;

  Future<void> registerWithEmailAndPassword(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      _user = userCredential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _showErrorSnackbar(context, e.message ?? 'An unknown error occurred');
    }
  }

  Future<void> loginWithEmailAndPassword(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      _user = userCredential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _showErrorSnackbar(context, e.message ?? 'An unknown error occurred');
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      _user = null;
      notifyListeners();
    } catch (e) {
      _showErrorSnackbar(context, 'Failed to sign out');
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        AppCustomNavigator.replace(context, const LoginScreen());
        return;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      _user = userCredential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _showErrorSnackbar(context, e.message ?? 'An unknown error occurred');
    } catch (e) {
      _showErrorSnackbar(context, 'An unknown error occurred');
    }
  }

  Future<void> signInWithApple(BuildContext context) async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      UserCredential userCredential = await _auth.signInWithCredential(oauthCredential);
      _user = userCredential.user;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      _showErrorSnackbar(context, e.message ?? 'An unknown error occurred');
    } catch (e) {
      _showErrorSnackbar(context, 'An unknown error occurred');
    }
  }

  Future<void> sendPasswordResetEmail(BuildContext context, String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password reset email sent')),
      );
    } on FirebaseAuthException catch (e) {
      _showErrorSnackbar(context, e.message ?? 'An unknown error occurred');
    }
  }

  void _showErrorSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}