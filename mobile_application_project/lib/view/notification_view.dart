import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Notification'),
      //   backgroundColor: Colors.white,
      // ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const Padding(
          //   padding: EdgeInsets.all(16),
          //   child: Text(
          //     'Notifications',
          //     style: TextStyle(
          //       fontSize: 24,
          //       fontWeight: FontWeight.bold,
          //     ),
          //   ),
          // ),
          Expanded(
            child: ListView(
              children: [
                _buildNotificationItem(
                  'assets/kathmandu_kings.png',
                  'Kathmandu Kings liked your post about team practice',
                  '2 min ago',
                  'View',
                ),
                _buildNotificationItem(
                  'assets/pokhara_panthers.png',
                  'Pokhara Panthers commented: "Great defensive strategy!"',
                  '1 hour ago',
                  'Reply',
                ),
                _buildNotificationItem(
                  'assets/nepal_sports.png',
                  'Nepal Sports League Tournament registration opens tomorrow!',
                  '5 hours ago',
                  'Details',
                ),
                _buildNotificationItem(
                  'assets/sportgear.png',
                  'SportGear Nepal liked your equipment review',
                  '8 hours ago',
                  'View',
                ),
              ],
            ),
          ),
          // Center(
          //   child: SizedBox(
          //     width: 400,
          //     child: ElevatedButton(
          //       onPressed: () {},
          //       child: const Center(
          //         child: Text(
          //           'View All Notifications',
          //           // style: TextStyle(
          //           //   color: Colors.black87,
          //           //   fontSize: 16,
          //           // ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 10),
          //   Container(
          //     decoration: BoxDecoration(
          //       border: Border(top: BorderSide(color: Colors.grey[300]!)),
          //     ),
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 12),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceAround,
          //         children: [
          //           _buildNavItem(Icons.home, 'Home', false),
          //           _buildNavItem(Icons.notifications, 'Notifications', true),
          //           _buildNavItem(Icons.person, 'Profile', false),
          //         ],
          //       ),
          //     ),
          //   ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(
      String imagePath, String text, String time, String action) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundColor: Colors.grey[200],
        child: Icon(Icons.sports_basketball, color: Colors.grey[600]),
      ),
      title: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        time,
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
      ),
      trailing: TextButton(
        onPressed: () {},
        child: Text(
          action,
          style: const TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.black : Colors.grey,
        ),
        Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.grey,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
