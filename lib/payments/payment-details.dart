import 'package:flutter/material.dart';

// Define the new page
class PaymentDetail extends StatelessWidget {
  const PaymentDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment details'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to new page using the defined route
            Navigator.pushNamed(context, '/main');
          },
          child: Text('Home'),
        ),
      ),
    );
  }
}
