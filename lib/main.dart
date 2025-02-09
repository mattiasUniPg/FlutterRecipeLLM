import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'pages.dart/home.dart';
import 'pages.dart/login.dart';
import 'pages.dart/mixitup.dart';
import 'pages.dart/publicrecipes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jwyjfvwduinhjuvdkwpm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imp3eWpmdndkdWluaGp1dmRrd3BtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzkxMTMyMTIsImV4cCI6MjA1NDY4OTIxMn0.obiT3oqw3BlDZCEaLclDJZv36SpJj_XpHGfOPYpVd6k',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      },
    );
  }
}

