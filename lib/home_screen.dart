import 'package:flutter/material.dart';

// --- HOME SCREEN ---

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  // Define the colors from the splash screen
  final Color _startColor = const Color(0xFF48006D); // Dark Purple
  final Color _endColor = const Color(0xFF050067);   // Dark Blue
  final Color _buttonColor = const Color(0xFF2600FF); // Bright Blue (#2600FF)

  // Controller for the button animation
  late AnimationController _buttonController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize Controller for the slide-in/fade-in animation
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 800), // Animation duration
      vsync: this,
    );

    // Slide Animation: Button starts from below the screen and slides up
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start 100% off-screen below
      end: Offset.zero,          // End at its normal position
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeOut,
    ));

    // Opacity Animation: Button fades in
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.easeIn,
      ),
    );

    // Start the animation when the screen is loaded
    _buttonController.forward();
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The AppBar has a gradient-matching color and the title
      appBar: AppBar(
        title: const Text(
          'Quiz 666',
          // The DoHyeon font is applied here via the MaterialApp theme
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: _startColor,
        elevation: 0, // Remove shadow
      ),

      // The Body must have the gradient background
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

        child: Stack(
          children: [
            // Centered "Are You Ready?" Text
            Center(
              child: Text(
                'Are You Ready?',
                style: TextStyle(
                  fontFamily: 'DoHyeon',
                  fontSize: 36,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),

            // Animated Start Button at the Bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0), // Space from the bottom edge

                // Apply the slide-up and fade-in animations
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85, // 85% width
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement navigation to the next screen (e.g., Registration)
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Start Button Pressed!')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _buttonColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30), // Highly rounded corners
                          ),
                          elevation: 10,
                          textStyle: const TextStyle(
                            fontFamily: 'DoHyeon',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: const Text('Start'),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}