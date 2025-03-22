import 'package:flutter/material.dart';
import 'package:flutter_firestore/user/create_account.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late Database _database;
  bool _isLoading = true;
  late BuildContext buildContext;

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  // Initialize the database
  Future<void> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'app_data.db');
    _database = await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE user_data(id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT)",
      );
    });
    _checkDataFromDatabase();
  }

  // Check data from the database and navigate based on the result
  Future<void> _checkDataFromDatabase() async {
    print('reached _checkDataFromDatabase');
    // Simulating a delay for loading data
    await Future.delayed(Duration(seconds: 2));

    final List<Map<String, dynamic>> data = await _database.query('user_data');
    for (var dt in data) {
      print('got the data from local sqlite${dt.toString()}');
    }


    setState(() {
      _isLoading = false;
    });

    if (data.isNotEmpty) {
      print('reached data is empty');
      // If data exists, navigate to the DataScreen
      Navigator.pushReplacement(
        context as BuildContext,
        MaterialPageRoute(builder: (context) => DataScreen(data: data)),
      );

    } else {
      print('reached data available');
      // If no data exists, navigate to the NoDataScreen
      Navigator.pushReplacement(
        context as BuildContext,
        MaterialPageRoute(builder: (context) => NoDataScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading and Navigation Example'),
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : CreateAccountWidget(), // Empty container when loading is false
      ),
    );
  }
}


class DataScreen extends StatelessWidget {
  final List<Map<String, dynamic>> data;

  DataScreen({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Data retrieved from the database:'),
            SizedBox(height: 10),
            Text('Email: ${data[0]['email']}'),
          ],
        ),
      ),
    );
  }
}

class NoDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('No Data Screen'),
      ),
      body: Center(
        child: Text('No data found in the database.'),
      ),
    );
  }
}