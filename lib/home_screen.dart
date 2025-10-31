import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // A simple container so the app doesn't crash after the splash screen
    return const Scaffold(
      body: Center(
        child: Text(
          'Home Screen Placeholder. Ready for your design!',
          style: TextStyle(fontSize: 20, color: Colors.blueGrey),
        ),
      ),
    );
  }
}