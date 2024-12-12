import 'package:flutter/material.dart';
import 'package:mobile_application_project/view/Registration_View.dart';
import 'package:mobile_application_project/view/landing_view.dart';
import 'package:mobile_application_project/view/Login_View.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}
