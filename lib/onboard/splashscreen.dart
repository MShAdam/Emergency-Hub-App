import 'dart:async';
import 'package:flutter/material.dart';
import 'package:emergancyhub/onboard/onboarding1.dart';

class splashScreenScreen extends StatefulWidget {

  @override
  State<splashScreenScreen> createState() => _splashScreenScreenState();
}

class _splashScreenScreenState extends State<splashScreenScreen> {
  @override
  void initState() {
    super.initState();
    // Start the timer when the splash screen is created
    Timer(Duration(seconds: 5), () {
      // Redirect to the home screen after 3 seconds
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => onboard1Screen()),
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/img/Splash Screen.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
  }
}