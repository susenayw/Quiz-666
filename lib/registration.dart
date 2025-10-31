import 'package:flutter/material.dart';

// --- REGISTRATION SCREEN ---

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> with SingleTickerProviderStateMixin {
  // Define the colors
  final Color _startColor = const Color(0xFF48006D); // Dark Purple
  final Color _endColor = const Color(0xFF050067);   // Dark Blue
  final Color _buttonColor = const Color(0xFF2600FF); // Bright Blue (#2600FF)
  final Color _hintColor = const Color(0xFF8A8A8A);   // Gray (#8A8A8A)
  final Color _inputBackground = Colors.black;        // Black input background

  // Controller for the animation sequence
  late AnimationController _controller;

  // Animation for the "Please enter your name" text (Fades in over 0.0 - 0.4 interval)
  late Animation<double> _textOpacityAnimation;

  // Animation for the Name Input and Confirm Button (Slides and Fades in over 0.4 - 1.0 interval)
  late Animation<double> _formOpacityAnimation;
  late Animation<Offset> _formSlideAnimation;

  // Text Controller for the input field
  final TextEditingController _nameController = TextEditingController();


  @override
  void initState() {
    super.initState();

    // The entire animation sequence duration
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward(); // Start the animation immediately

    // Stage 1: Text Fade In (0.0 to 0.4 interval)
    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    // Stage 2: Form/Button Fade In (0.4 to 1.0 interval)
    _formOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeIn),
      ),
    );

    // Stage 2: Form/Button Slide Up (0.4 to 1.0 interval)
    _formSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1), // Starts slightly lower than final position
      end: Offset.zero,           // Ends at final position
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
      // AppBar is intentionally left out to match the Figma prototype (no navigation bar)

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          // Gradient Background
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
              // Stage 1: "Please enter your name" Text
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

              // Stage 2: Input Field and Button Container
              SlideTransition(
                position: _formSlideAnimation,
                child: FadeTransition(
                  opacity: _formOpacityAnimation,
                  child: Column(
                    children: [
                      // Name Input Field
                      TextField(
                        controller: _nameController,
                        autofocus: true, // Automatically opens keyboard (Stage 3)
                        style: const TextStyle(color: Colors.white, fontFamily: 'DoHyeon', fontSize: 18),
                        cursorColor: _buttonColor,
                        decoration: InputDecoration(
                          hintText: 'Name :',
                          hintStyle: TextStyle(color: _hintColor, fontFamily: 'DoHyeon'),
                          filled: true,
                          fillColor: _inputBackground,
                          // No borders for a clean look
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Confirm Button
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            // Only proceed if the name is not empty
                            if (_nameController.text.isNotEmpty) {
                              // TODO: Navigate to the Quiz Page, passing the name
                              print('Confirmed name: ${_nameController.text}');
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Welcome, ${_nameController.text}!')),
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