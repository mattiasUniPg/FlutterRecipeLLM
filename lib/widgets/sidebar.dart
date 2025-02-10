import 'package:cookingnf/screen/resetpwd.dart';
import 'package:flutter/material.dart';

class AppSidebar extends StatelessWidget {
  
  BuildContext? get context => null;
  
  String? get userEmail => null;
  
  get onSignOut => null;
  
  get selectedIndex => null;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.black,
      child: Column(
        children: [
          // App Title
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Recipe App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(color: Colors.white24, height: 1),
          // Navigation Items
          Expanded(
            child: ListView(
              children: [
                _buildNavItem(Icons.login, 'Login', 3),
                _buildNavItem(Icons.home, 'Home', 0),
                _buildNavItem(Icons.shuffle, 'Mix It Up', 2),
                _buildNavItem(Icons.public, 'Public', 1),
                _buildNavItem(Icons.lock_reset, 'Reset Password', 4),
              ],
            ),
          ),
          Divider(color: Colors.white24, height: 1),
          // User Info and Sign Out
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.person, color: Colors.black),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        userEmail!,
                        style: TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: onSignOut,
                  child: Text('Sign Out'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black, backgroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 36),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, int index) {
    final isSelected = selectedIndex == index;
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      selected: isSelected,
      selectedTileColor: Colors.white24,
      onTap: () {
        if (title == 'Reset Password') {
          Navigator.push(
            context!,
            MaterialPageRoute(builder: (context) => ResetPasswordScreen()),
          );
        } else {
          onItemTapped(index);
        }
      },
    );
  }
  
  void onItemTapped(int index) {
    print('Item $index tapped');
  }
}

