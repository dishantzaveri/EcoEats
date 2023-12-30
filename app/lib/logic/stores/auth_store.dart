// Create a class AuthStore that extends ChangeNotifier and uses singleton pattern.
//
// Path: lib/logic/stores/auth_store.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../utils/const.dart';

class AuthStore extends ChangeNotifier {
  AuthStore._();

  static final AuthStore _instance = AuthStore._();

  factory AuthStore() {
    return _instance;
  }

  bool isAuthenticated = false;

  bool authStateChanges() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        isAuthenticated = false;
        logger.d('User is currently signed out!');
      } else {
        isAuthenticated = true;
        logger.d('User is signed in!');
      }
    });
    return isAuthenticated;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    isAuthenticated = false;
    notifyListeners();
  }

  // Login with email and password
  Future<bool> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      isAuthenticated = true;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        logger.d('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        logger.d('Wrong password provided for that user.');
      }
    }
    return isAuthenticated;
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // Sign in with Google
  Future<bool> loginWithGoogle() async {
    logger.d("loginWithGoogle");
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      logger.d("googleAuth: $googleAuth, googleUser: $googleUser");

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      isAuthenticated = true;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        logger.d('The account already exists with a different credential.');
      } else if (e.code == 'invalid-credential') {
        logger.d('Error occurred while accessing credentials. Try again.');
      }
    } catch (e) {
      logger.d(e);
    }
    return isAuthenticated;
  }

  // Sign up with email and password
  Future<bool> signUpWithEmailAndPassword({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      isAuthenticated = true;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        logger.d('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        logger.d('The account already exists for that email.');
      }
    } catch (e) {
      logger.d(e);
    }
    return isAuthenticated;
  }
}
