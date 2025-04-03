import 'package:flutter/material.dart';
import 'user.dart';
import 'user_firestore.dart';
import 'user_setup_login.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class CreateAccountWidget extends StatefulWidget {
  const CreateAccountWidget({super.key});

  @override
  State<CreateAccountWidget> createState() => _CreateAccountWidgetState();
}

class _CreateAccountWidgetState extends State<CreateAccountWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  late Database _database;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }


// Initialize the database
  Future<void> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'users.db');
    // deleteDatabase(path);

    _database = await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE user(email TEXT PRIMARY KEY UNIQUE, firstName TEXT, lastName TEXT, address TEXT, phone TEXT)",
      );
    });

  }

  // Insert data into the SQLite database
  Future<void> _insertData(String firstName, String lastName, String email, String address, String phone) async {
    // deleteUser(email);
    await _database.insert(
      'user',
      {'firstName': firstName, 'lastName': lastName, 'email': email, 'address': address, 'phone': phone},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateUser(User user) async {
    await _database.update('user', user.toMap(), where: 'email = ?', whereArgs: [user.email],);
  }

  Future<void> deleteUser(String email) async {
    print('reached delete user by email $email');
    await _database.delete('user', where: 'email = ?', whereArgs: [email],);
  }

  // Get data into the SQLite database
  Future<List<dynamic>> _getUserData() async {
    final List<Map<String, dynamic>> users = await _database.query('user');
    return [
      for (final {'firstName': firstName as String, 'lastName': lastName as String, 'email': email, 'address': address, 'phone': phone } in users)
        User(firstName: firstName, lastName: lastName, email: email, address: address, phone: phone),
    ];
  }


  // Function to submit the form data to the API
  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {


      final firstName = _firstNameController.text.trim();
      final lastName = _lastNameController.text.trim();
      final email = _emailController.text.trim();
      final address = _addressController.text.trim();
      final phone = _phoneController.text.trim();

      final user = User(firstName: firstName, lastName: lastName, email: email, address: address, phone: phone);

      // Sign in the user by email and passwrod, for now the password is dummy now
      UserSetupLogin().createAccountWithEmailAndPassword(email, 'password');

      // Try to get the user from fire store
      UserService().getUser(email).then((_) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('Firestore:::get user by email success')),
        );
      }).catchError((error) {
        print('Firestore:::Error while getting user by email: $error');
        /*ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('Firestore:::Error while getting user by email: $error')),
        );*/
      });

      // insert data to firestore
      UserService().addUser(user).then((_) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('Firestore:::Data saved successfully')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('Firestore:::Error: $error')),
        );
      });

      // Insert the form data into the database
      /*_insertData(firstName, lastName, email, address, phone).then((_) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('Data saved successfully')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      });*/

      print('before printing the user data in the local SQLite database');
      List<dynamic> users = await _getUserData();
      for (var user in users) {
        print('create_account|_getUserData|User: {${user.firstName.toString()}, ${user.lastName.toString()}, ${user.email.toString()}, ${user.address.toString()}, ${user.phone.toString()}}');
      }



      // API URL where you want to submit the data
      final url = 'https://your-api-url.com/submit-form';
        // Prepare form data for http call
        final formData = {
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'email': _emailController.text,
          'address': _addressController.text,
          'phone': _phoneController.text,
        };
      try {
        final response = await http.post(
          Uri.parse(url),
          body: json.encode(formData),
          headers: {'Content-Type': 'application/json'},
        );

        if (response.statusCode == 200) {
          // Successful submission
          _showSuccessDialog();
          _sendEmailConfirmation(formData['email'].toString());
        } else {
          // Handle error response
          _showErrorDialog('Failed to submit the form. Please try again.');
        }
      } catch (e) {
        // Handle network or other errors
        _showErrorDialog('An error occurred: $e');
      }
    }
  }

  // Function to show success dialog
  void _showSuccessDialog() {
    print("success");
    showDialog(
      context: context as BuildContext,
      builder: (context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Form submitted successfully! You will receive a confirmation email shortly.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  // Function to show error dialog
  void _showErrorDialog(String message) {
    print("error$message");
    /*showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );*/
  }

  // Mock function to simulate sending an email confirmation
  Future<void> _sendEmailConfirmation(String email) async {
    // Simulating email confirmation after form submission
    await Future.delayed(Duration(seconds: 2)); // Simulate email sending delay
    print('Email confirmation sent to $email');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
