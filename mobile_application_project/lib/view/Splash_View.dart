import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  final Function onNext;

  SplashScreen({required this.onNext}); // Callback function for navigation

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  // Simulate the loading and navigate to the next screen after a delay
  void _startLoading() {
    Timer(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      // Call the onNext function passed to navigate after splash
      widget.onNext();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Use white background like LandingView
      body: Center(
        child: AnimatedOpacity(
          opacity: _isLoading ? 1.0 : 0.0,
          duration: Duration(seconds: 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image that matches the style (like logo or app branding)
              Image.asset(
                'assets/images/logoe.png', // Adjust the image path as needed
                height: 120.0, // Set a size for the logo
              ),
              SizedBox(height: 32.0),
              // Loading text with a more consistent style
              Text(
                "Please Wait...",
                style: TextStyle(
                  fontFamily: 'cursive', // Same font as in LandingView
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Text color for consistency
                ),
              ),
              SizedBox(height: 20),
              // CircularProgressIndicator with updated color
              CircularProgressIndicator(
                color: Colors.black, // Dark color to match text
              ),
            ],
          ),
        ),
      ),
    );
  }
}
