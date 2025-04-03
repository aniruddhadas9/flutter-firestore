// User Service class to interact with Firestore
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firestore/user/user.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add user to Firestore
  Future<void> addUser(User user) async {
    try {
      print('User service | add user: ${user.toString()}');
      await _firestore.collection('user').doc(user.email).set(user.toMap());
      print('User added successfully');
    } catch (e) {
      print('Error adding user: $e');
      rethrow;
    }
  }

  // Fetch user by ID
  Future<User?> getUser(String email) async {
    try {
      print('User service | get user|email: $email');
      DocumentSnapshot doc =
          await _firestore.collection('user').doc(email).get();
      if (doc.exists) {
        return User.fromMap(doc.data() as Map<String, dynamic>);
      } else {
        print('Error fetching user| User with email $email does not exist');
      }
    } catch (e) {
      print('Error fetching user: $e');
    }
    return null;
  }

  // Update user in Firestore
  Future<void> updateUser(User user) async {
    try {
      await _firestore.collection('user').doc(user.email).update(user.toMap());
      print('User updated successfully');
    } catch (e) {
      print('Error updating user: $e');
      rethrow;
    }
  }

  // Delete user from Firestore
  Future<void> deleteUser(String email) async {
    try {
      await _firestore.collection('user').doc(email).delete();
      print('User deleted successfully');
    } catch (e) {
      print('Error deleting user: $e');
      rethrow;
    }
  }
}
