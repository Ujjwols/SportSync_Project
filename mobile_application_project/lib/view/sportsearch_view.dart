import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Padding(
          padding: const EdgeInsets.only(
              top: 20
              ), // Adjust left padding for alignment
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        title: const SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
                top: 30), // Add padding to move the TextField down
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search...',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              ),
            ),
          ),
        ),
      ),
      body: const Center(
        child: Text(
          'Search Results Will Appear Here',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
