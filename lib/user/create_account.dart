import 'package:flutter/material.dart';
import 'package:flutter_firestore/user/user.dart';
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
  final TextEditingController _nameController = TextEditingController();
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
    final path = join(directory.path, 'user_data.db');
    _database = await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, email TEXT, address TEXT, phone TEXT)",
      );
    });
  }

  // Insert data into the SQLite database
  Future<void> _insertData(String name, String email, String address, String phone) async {
    await _database.insert(
      'user',
      {'name': name, 'email': email, 'address': address, 'phone': phone},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Insert data into the SQLite database
  Future<List<dynamic>> _getUserData() async {

    final List<Map<String, dynamic>> users = await _database.query('user');
    return [
      for (final {'id': id as int, 'name': name as String, 'email': email, 'address': address, 'phone': phone } in users)
        User(id: id, name: name, email: email, address: address, phone: phone),
    ];
    for (var dt in users) {
      print('got the data from local sqlite${dt.toString()}');
      print('got the data from local sqlite${dt.toString()}');
    }
  }


  // Function to submit the form data to the API
  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() ?? false) {


      final name = _nameController.text.trim();
      final email = _emailController.text.trim();
      final address = _addressController.text.trim();
      final phone = _phoneController.text.trim();
      // Insert the form data into the database
      _insertData(name, email, address, phone).then((_) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('Data saved successfully')),
        );
      }).catchError((error) {
        ScaffoldMessenger.of(context as BuildContext).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      });

      print('before printing the user data in the local SQLite database');
      List<dynamic> users = await _getUserData();
      users.forEach((user){
        print('user tostring {${user.name.toString()} ${user.email.toString()}}');
      });



      // API URL where you want to submit the data
      final url = 'https://your-api-url.com/submit-form';
        // Prepare form data for http call
        final formData = {
          'name': _nameController.text,
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
    /*showDialog(
      context: context,
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
    );*/
  }

  // Function to show error dialog
  void _showErrorDialog(String message) {
    print("error${message}");
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
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
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
