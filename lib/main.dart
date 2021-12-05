import 'package:flutter/material.dart';
import 'package:flutter_practice/feature/dashboard/dashboard_screen.dart';

// User model
// Get user by id (1)
// Save user to state
// Render Dashboard once user is set
// Todo model
// Get TODOs by user id

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DashboardScreen(),
    );
  }
}
