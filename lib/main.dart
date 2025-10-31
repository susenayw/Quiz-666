import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'splash.dart'; // Import the splash screen
// Note: HomeScreen is imported by splash.dart, but we'll import it here too if needed later.

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz 666 App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'DoHyeon', // Set the custom font
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Start the app with the SplashScreen
      home: const SplashScreen(),
    );
  }
}