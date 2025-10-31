import 'package:flutter/material.dart';
import 'registration.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  final Color _startColor = const Color(0xFF48006D);
  final Color _endColor = const Color(0xFF050067);
  final int _totalQuestions = 10;

  @override
  Widget build(BuildContext context) {
    final String userName = UserData.userName;
    final int score = UserData.score;

    final String resultMessage = '$userName you scored $score/$_totalQuestions.';

    return Scaffold(

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
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  resultMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'DoHyeon',
                    fontSize: 32,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 1.5,
                    shadows: [
                      Shadow(
                        color: Colors.black45,
                        blurRadius: 5,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 60),

                ElevatedButton(
                  onPressed: () {

                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: _endColor,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 10,
                    shadowColor: Colors.purple.shade700,
                  ),
                  child: const Text(
                    'Continue to Home',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
