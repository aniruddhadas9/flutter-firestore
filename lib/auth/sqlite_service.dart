import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  late Database _database;
  bool _isLoading = true;

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
    log('reached _checkDataFromDatabase');
    // Simulating a delay for loading data
    await Future.delayed(Duration(seconds: 2));

    final List<Map<String, dynamic>> data = await _database.query('user_data');
    for (var dt in data) {
      log('got the data from local sqlite${dt.toString()}');
    }

    if (data.isNotEmpty) {
      log('reached data is empty');


    } else {
      log('reached data available');

    }
  }

}