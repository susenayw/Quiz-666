import 'package:flutter/material.dart';
import 'home_screen.dart';

// --- SPLASH SCREEN ---

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  final Color _startColor = const Color(0xFF48006D);
  final Color _endColor = const Color(0xFF050067);
  final Duration _totalDuration = const Duration(seconds: 4);

  late AnimationController _gradientController;
  late Animation<Color?> _gradientColorTween1;
  late Animation<Color?> _gradientColorTween2;
  late AnimationController _logoController;
  late Animation<double> _logoOpacityAnimation;

  @override
  void initState() {
    super.initState();

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

    _logoController = AnimationController(
      duration: _totalDuration - const Duration(seconds: 1),
      vsync: this,
    );
    _logoOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    _gradientController.forward().then((_) {
      _logoController.forward();
    });

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
                    'assets/images/logo-quiz-666.png',
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
