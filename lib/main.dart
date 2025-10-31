import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Force the app to stay in portrait mode
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
        // Set DoHyeon as the default font family for the entire app
        fontFamily: 'DoHyeon',
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Start the app with the SplashScreen
      home: const SplashScreen(),
    );
  }
}
