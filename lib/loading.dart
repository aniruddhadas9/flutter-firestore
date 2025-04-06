import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_firestore/auth/login_screen.dart';
import 'package:flutter_firestore/home_screen.dart';
import 'auth/auth_service.dart';
import 'user/create_account.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final authService = AuthService();
  String appStatus = 'loading';
  bool _isLoading = true;
  late BuildContext buildContext;

  @override
  void initState() {
    super.initState();
    if (authService.isUserLoggedIn) {
      String user = authService.getCurrentUserDetails();
      log('currentUser: $user');
      appStatus = 'loggedIn';
    } else {
      appStatus = 'notLoggedIn';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Loading and Navigation Example')),
        body: Center(
            child: Builder(
                builder: (context) {
                  if (appStatus == 'loading') {
                    return const CircularProgressIndicator();
                  } else if (appStatus == 'loggedIn') {
                    return const HomeScreen();
                  } else if (appStatus == 'notLoggedIn') {
                    return const LoginScreen();
                  } else {
                    return const CreateAccountWidget();
                  }
                }
            )
        )
    );
  }
}