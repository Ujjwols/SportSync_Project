import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_application_project/features/splash/presentation/view/splash_view.dart'; // Import SplashView
import 'package:mobile_application_project/features/splash/presentation/view_model/splash_cubit.dart'; // Import SplashCubit

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<LandingView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Welcome to SportsSync',
      'description':
          'Manage your team, find matches, and connect effortlessly.',
      'image': 'assets/images/logoe.png',
    },
    {
      'title': 'Create Team Profiles',
      'description':
          'Easily create and manage team profiles for your sports needs.',
      'image': 'assets/images/Teams.png',
    },
    {
      'title': 'Post For teams',
      'description': 'Connect with other teams through Posts update',
      'image': 'assets/images/connect.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: _onboardingData.length,
              itemBuilder: (context, index) {
                final data = _onboardingData[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        data['image']!,
                        height: 200.0,
                      ),
                      const SizedBox(height: 32.0),
                      Text(
                        data['title']!,
                        style: const TextStyle(
                          fontFamily: 'cursive',
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        data['description']!,
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Dots Indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _onboardingData.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: _currentIndex == index ? 12.0 : 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: _currentIndex == index ? Colors.black : Colors.grey,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24.0),

          // Get Started Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  if (_currentIndex == _onboardingData.length - 1) {
                    // Navigate to SplashView when onboarding is completed
                    // Read SplashCubit to handle necessary logic
                    context.read<SplashCubit>();

                    // Navigate to SplashView
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SplashView(),
                      ),
                    );
                  } else {
                    // Go to the next onboarding screen
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: Text(
                  _currentIndex == _onboardingData.length - 1
                      ? 'Get Started'
                      : 'Next',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
