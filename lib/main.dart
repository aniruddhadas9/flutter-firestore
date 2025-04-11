import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firestore/auth/login_screen.dart';
import 'package:flutter_firestore/auth/signup_screen.dart';
import 'package:flutter_firestore/flat-detail/FlatRentStart.dart';
import 'package:flutter_firestore/home_screen.dart';
import 'package:flutter_firestore/loading.dart';
import 'package:flutter_firestore/payments/payment-details.dart';
import 'auth/auth_service.dart';
import 'firebase_options.dart';
import 'flat-detail/flat-detail.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'KRenterFireStore',
    options: DefaultFirebaseOptions.currentPlatform,
  ).catchError((error) {
    log(" Firebase.initializeApp|||| the error is $error");
    return error;
  });

  /*await Firebase.initializeApp(
    demoProjectId: "demo-krenter-project-id",
  ).catchError((error) {
    log(" Firebase.initializeApp|||| the error is $error");
    return error;
  });*/

  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      log('User is currently signed out!');
    } else {
      log('User is signed in!');
    }
  });

  FirebaseAuth.instance.idTokenChanges().listen((User? user) {
    if (user == null) {
      log('User is currently signed out!');
    } else {
      log('User is signed in!');
    }
  });

  FirebaseAuth.instance.userChanges().listen((User? user) {
    if (user == null) {
      log('User is currently signed out!');
    } else {
      log('User is signed in!');
    }
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: FlatRentStart(),
      // home: HomeScreen(),
      // home: const MyHomePage(title: 'KRenter Firestore'),
      routes: {
        '/main': (context) => MyApp(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        // Define route for new page
        '/homePage': (context) => HomeScreen(),
        '/loading': (context) => LoadingScreen(),
        // Define route for new page
        '/flatDetail': (context) => FlatDetail(),
        // Define route for new page
        // '/newPayment': (context) => NewPayment(), // Define route for new page
        '/paymentDetail': (context) => PaymentDetail(),
        // Define route for new page
        '/serviceRequest': (context) => FlatDetail(),
        // Define route for new page
      },
    );
  }
}
