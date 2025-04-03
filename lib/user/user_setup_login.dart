import 'package:firebase_auth/firebase_auth.dart';

class UserSetupLogin {
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // User signed in successfully
      print("User signed in: ${userCredential.user?.email}");
    } catch (e) {
      // Handle sign-in errors
      print("Error signing in: $e");
    }
  }

  Future<void> createAccountWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // User successfully created
    } on FirebaseAuthException catch (e) {
      // Handle errors (e.g., weak password, email already in use)
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
  }


}
