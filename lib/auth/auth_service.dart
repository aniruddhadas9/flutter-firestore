import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  bool isUserLoggedIn = false;
  User? _user;
  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("AuthService|createUserWithEmailAndPassword|Something went wrong $e");
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("AuthService|loginUserWithEmailAndPassword|Something went wrong $e");
    }
    return null;
  }

  Future<bool> checkCurrentUserLoginStatus() async {
    _user = _auth.currentUser;
    if (_user != null) {
      // User is not logged in, redirect to login
      isUserLoggedIn = true;
      return true;
    } else {
      isUserLoggedIn = false;
    }
    return false;
  }

  String getCurrentUserDetails() {
    return _auth.currentUser.toString();
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
      isUserLoggedIn = false;
    } catch (e) {
      log("AuthService|signout|Something went wrong $e");
    }
  }
}
