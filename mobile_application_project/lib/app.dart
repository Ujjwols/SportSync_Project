import 'package:flutter/material.dart';
import 'package:mobile_application_project/view/landing_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingView(),
    );
  }
}
