


import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestoreService {
  final FirebaseFirestore db;

  const CloudFirestoreService(this.db);

  Future<String> add(Map<String, dynamic> data) async {

    try {
      // final userCredential =
      // final credential = GoogleAuthProvider.credential(idToken: idToken);
      log("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          log("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          log("Unknown error.");
      }
    }

    log('reached storing data part');
    log(data.toString());
    // Add a new document with a generated ID
    final document = await db.collection('user')
        .add(data);
    return document.id;
  }

  // get all `user` collection's documents
  Stream<QuerySnapshot<Map<String, dynamic>>> getUsers() {
    return db.collection('user').snapshots();
  }


}