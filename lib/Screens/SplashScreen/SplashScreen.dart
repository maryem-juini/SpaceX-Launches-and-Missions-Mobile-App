import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:project/Screens/HomeScreen/HomePage.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FlutterSplashScreen.gif(
          useImmersiveMode: true,
          gifPath: 'assets/logo-white.png',
          gifWidth: size.width * 0.7,
          gifHeight: size.height * 0.2,
          backgroundColor: Color(0xFF06094C),
          nextScreen: const HomePage(),
          duration: const Duration(milliseconds: 2000),
        ),
      ),
    );
  }
}
