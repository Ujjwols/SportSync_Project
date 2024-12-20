import 'package:flutter/material.dart';
import 'package:mobile_application_project/view/Home_View.dart';
import 'package:mobile_application_project/view/notification_view.dart';
import 'package:mobile_application_project/view/profile_view.dart';
import 'package:mobile_application_project/view/sportsearch_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardView> {
  int _selectedIndex = 0; // Home is selected by default

  // List of Screens
  final List<Widget> lstBottomScreen = const [
    HomeView(), // Home Screen
    NotificationView(), // Notification Screen
    ProfileView(), // Profile Screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: const Text('SportSync'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: lstBottomScreen[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Change selected index
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
