import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages.dart/home.dart';
import 'pages.dart/login.dart';
import 'pages.dart/mixitup.dart';
import 'pages.dart/publicrecipes.dart';
import 'widgets/navbar.dart';
import 'widgets/sidebar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jwyjfvwduinhjuvdkwpm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp3eWpmdndkdWluaGp1dmRrd3BtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkxMTMyMTIsImV4cCI6MjA1NDY4OTIxMn0.obiT3oqw3BlDZCEaLclDJZv36SpJj_XpHGfOPYpVd6k',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        '/p-recipes': (context) => PublicRecipesScreen(),
        '/mix-it': (context) => MixItUpScreen(),
        '/login': (context) => LoginScreen(),
      },
    );
  }
}
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    HomeScreen(),
    PublicRecipesScreen(),
    MixItUpScreen(),
    LoginScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

   void _handleSignOut() {
    // Implement sign out logic here
    Navigator.pushReplacementNamed(context, '/login');
    print('User signed out');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                AppNavbar(onRouteChanged: (int ) {  },),
                Expanded(
                  child: _screens[_selectedIndex],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

