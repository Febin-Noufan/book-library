
import 'package:flutter/material.dart';


import 'package:go_router/go_router.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigate to HomeScreen after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      // Navigate using GoRouter
      context.go('/home'); // Adjust this path according to your router setup
    });

    return Scaffold(
      backgroundColor: Colors.orange, 
      body: Center(
        child: Image.asset(
          'assets/Frame 7.png', // Replace with your image asset path
          fit: BoxFit.contain, // Adjust the fit as needed
        ),
      ),
    );
  }
}
