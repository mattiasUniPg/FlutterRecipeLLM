import 'package:flutter/material.dart';

class AppNavbar extends StatelessWidget {
  final Function(int) onRouteChanged;

  const AppNavbar({Key? key, required this.onRouteChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.black,
      child: Row(
        children: [
          // Menu button
          PopupMenuButton<int>(
            icon: Icon(Icons.menu, color: Colors.white),
            onSelected: (int result) {
              onRouteChanged(result);
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              PopupMenuItem<int>(
                value: 0,
                child: Text('Home'),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Text('Public'),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Text('Mix It Up'),
              ),
              PopupMenuItem<int>(
                value: 3,
                child: Text('Login'),
              ),
            ],
          ),
          // App title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Recipe App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Spacer(),
          // User profile and email
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.black),
              ),
              SizedBox(width: 10),
              Text(
                'user@example.com',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 20),
            ],
          ),
        ],
      ),
    );
  }
}

