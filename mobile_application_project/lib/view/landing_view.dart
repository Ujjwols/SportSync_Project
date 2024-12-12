import 'package:flutter/material.dart';
import 'package:mobile_application_project/view/Registration_View.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('SportsSync'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 32.0),

              // App Logo
              Center(
                child: Image.asset(
                  'assets/icons/logo.png', // Replace with your app logo asset path
                  height: 120.0,
                ),
              ),
              SizedBox(height: 24.0),

              // Welcome Text
              Text(
                'Welcome to SportsSync',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0),
              Text(
                'Manage your team, find matches, and connect with other teams effortlessly.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32.0),

              // Features Section
              Column(
                children: [
                  _buildFeature(
                    icon: Icons.group,
                    title: 'Create Team Profiles',
                    description: 'Easily create and manage team profiles.',
                  ),
                  _buildFeature(
                    icon: Icons.sports_soccer,
                    title: 'Find Matches',
                    description:
                        'Connect with other teams to arrange matches at suitable times and venues.',
                  ),
                  _buildFeature(
                    icon: Icons.chat,
                    title: 'Team Communication',
                    description:
                        'Chat with other teams and coordinate effortlessly.',
                  ),
                ],
              ),
              SizedBox(height: 32.0),

              // Register Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () {
                    // Navigate to Registration Page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationView(),
                      ),
                    );
                  },
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.0),

              // Already Registered Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? '),
                  GestureDetector(
                    onTap: () {
                      // Navigate to Login Page
                      print('Navigate to login');
                    },
                    child: Text(
                      'Login here',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }

  // Feature Widget
  Widget _buildFeature(
      {required IconData icon,
      required String title,
      required String description}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 40.0,
            color: Colors.black,
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
