import 'package:flutter/material.dart';

// Define the new page
class FlatDetail extends StatelessWidget {
  const FlatDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flat details you rented'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to new page using the defined route
            Navigator.pushNamed(context, '/paymentDetail');
          },
          child: Text('Payment Detail'),
        ),
      ),
    );
  }
}

// Main app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      routes: {
        '/newPage': (context) => FlatDetail(), // Define route for new page
      },
    );
  }
}

// Home page with button to navigate
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to new page using the defined route
            Navigator.pushNamed(context, '/paymentDetail');
          },
          child: Text('Go to New Page'),
        ),
      ),
    );
  }
}