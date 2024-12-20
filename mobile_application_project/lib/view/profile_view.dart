import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.orange[100],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.sports_basketball,
                              size: 40,
                              color: Colors.orange,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Nepal Thunder Hawks',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Professional Basketball Team',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 16,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 16, color: Colors.red),
                                  Text(
                                    'Kathmandu, Nepal',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Established in 2010, Nepal Thunder Hawks has become one of the leading teams in professional basketball. Known for aggressive defense and dynamic offense. Led by team captain Rajesh Hamal, the Hawks continue to dominate the league.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[800],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: const Text(
                                'Stats',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: const Text(
                                'Message',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Team Roster',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildPlayerTile(
                        'Rajesh Hamal',
                        'Forward',
                        'assets/player1.jpg',
                      ),
                      _buildPlayerTile(
                        'Bhuwan KC',
                        'Guard',
                        'assets/player2.jpg',
                      ),
                      _buildPlayerTile(
                        'Dayahang Rai',
                        'Center',
                        'assets/player3.jpg',
                      ),
                      _buildPlayerTile(
                        'Bipin Karki',
                        'Forward',
                        'assets/player4.jpg',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //   decoration: BoxDecoration(
          //     border: Border(top: BorderSide(color: Colors.grey[300]!)),
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 12),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
          //       children: [
          //         _buildNavItem(Icons.home, 'Home', false),
          //         _buildNavItem(Icons.notifications, 'Notifications', false),
          //         _buildNavItem(Icons.person, 'Profile', true),
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildPlayerTile(String name, String position, String imagePath) {
    return ListTile(
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: AssetImage(imagePath),
        backgroundColor: Colors.grey[300],
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        position,
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
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
