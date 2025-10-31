import 'package:flutter/material.dart';
import 'registration.dart'; // To access UserData

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  final Color _startColor = const Color(0xFF48006D);
  final Color _endColor = const Color(0xFF050067);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Results'),
        backgroundColor: _startColor,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [_startColor, _endColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Congratulations, ${UserData.userName ?? 'User'}!',
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontFamily: 'DoHyeon',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'You scored: ${UserData.score} / 10',
                style: const TextStyle(
                  fontSize: 36,
                  color: Colors.white,
                  fontFamily: 'DoHyeon',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the Home Screen or Registration
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
