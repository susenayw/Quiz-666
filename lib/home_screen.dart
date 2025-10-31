import 'package:flutter/material.dart';
import 'registration.dart'; // Import the RegistrationScreen

// --- HOME SCREEN ---

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  // Define the colors
  final Color _startColor = const Color(0xFF48006D);
  final Color _endColor = const Color(0xFF050067);
  final Color _buttonColor = const Color(0xFF2600FF);

  late AnimationController _buttonController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _buttonController,
      curve: Curves.easeOut,
    ));

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _buttonController,
        curve: Curves.easeIn,
      ),
    );

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
      // AppBar with title "Quiz 666"
      appBar: AppBar(
        title: const Text(
          'Quiz 666',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: _startColor,
        elevation: 0,
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
                padding: const EdgeInsets.only(bottom: 40.0),
                child: SlideTransition(
                  position: _slideAnimation,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to the RegistrationScreen
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const RegistrationScreen()),
                          );
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
