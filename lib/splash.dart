import 'package:flutter/material.dart';
import 'home_screen.dart'; // We'll create this next

// --- SPLASH SCREEN ---

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  // Animation for Gradient Fade-in (0% to 100% color)
  late AnimationController _gradientController;
  late Animation<Color?> _gradientColorTween1;
  late Animation<Color?> _gradientColorTween2;

  // Animation for Logo Fade-in and Fade-out
  late AnimationController _logoController;
  late Animation<double> _logoOpacityAnimation;

  // Define the gradient colors based on your request (48006D and 050067)
  final Color _startColor = const Color(0xFF48006D);
  final Color _endColor = const Color(0xFF050067);
  final Duration _totalDuration = const Duration(seconds: 4); // Total time before transition

  @override
  void initState() {
    super.initState();

    // 1. Initialize Gradient Animation (runs for 2 seconds)
    _gradientController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _gradientColorTween1 = ColorTween(
      begin: Colors.black,
      end: _startColor,
    ).animate(_gradientController);
    _gradientColorTween2 = ColorTween(
      begin: Colors.black,
      end: _endColor,
    ).animate(_gradientController);

    // 2. Initialize Logo Animation (starts halfway through and fades out)
    _logoController = AnimationController(
      duration: _totalDuration - const Duration(seconds: 1), // 3 seconds total
      vsync: this,
    );
    _logoOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        // Logo fades in during 0.5s and then fades out for 2s
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Start the sequence
    _gradientController.forward().then((_) {
      // After gradient is fully visible (2s), start the logo animation
      _logoController.forward();
    });

    // Navigate to the next screen after the full total duration
    Future.delayed(_totalDuration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _gradientController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge([_gradientController, _logoController]),
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              // Apply the animated gradient colors
              gradient: LinearGradient(
                colors: [
                  _gradientColorTween1.value ?? _startColor,
                  _gradientColorTween2.value ?? _endColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              // The Logo fades in and out based on the logoController
              child: FadeTransition(
                opacity: _logoOpacityAnimation,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Image.asset(
                    'assets/images/logo-quiz-666.png', // Correct asset path
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}