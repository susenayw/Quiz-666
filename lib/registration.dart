import 'package:flutter/material.dart';
import 'quiz.dart';

class UserData {
  static String userName = '';
  static int score = 0;
}

// --- REGISTRATION SCREEN ---

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> with SingleTickerProviderStateMixin {
  final Color _startColor = const Color(0xFF48006D);
  final Color _endColor = const Color(0xFF050067);
  final Color _buttonColor = const Color(0xFF2600FF);
  final Color _hintColor = const Color(0xFF8A8A8A);
  final Color _inputBackground = Colors.black;

  late AnimationController _controller;

  late Animation<double> _textOpacityAnimation;

  late Animation<double> _formOpacityAnimation;
  late Animation<Offset> _formSlideAnimation;

  final TextEditingController _nameController = TextEditingController();


  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();

    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    _formOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    _formSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _textOpacityAnimation,
                child: Text(
                  'Please enter your name',
                  style: TextStyle(
                    fontFamily: 'DoHyeon',
                    fontSize: 24,
                    color: _hintColor,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SlideTransition(
                position: _formSlideAnimation,
                child: FadeTransition(
                  opacity: _formOpacityAnimation,
                  child: Column(
                    children: [
                      TextField(
                        controller: _nameController,
                        autofocus: true,
                        style: const TextStyle(color: Colors.white, fontFamily: 'DoHyeon', fontSize: 18),
                        cursorColor: _buttonColor,
                        decoration: InputDecoration(
                          hintText: 'Name :',
                          hintStyle: TextStyle(color: _hintColor, fontFamily: 'DoHyeon'),
                          filled: true,
                          fillColor: _inputBackground,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        ),
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_nameController.text.isNotEmpty) {
                              UserData.userName = _nameController.text.trim();

                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => const QuizScreen()),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please enter a name to continue.')),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _buttonColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 10,
                            textStyle: const TextStyle(
                              fontFamily: 'DoHyeon',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Text('Confirm'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
