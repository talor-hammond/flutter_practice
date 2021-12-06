import 'package:flutter/material.dart';
import 'package:flutter_practice/feature/dashboard/dashboard_screen.dart';
import 'package:flutter_practice/feature/landing/landing_screen.dart';
import 'package:flutter_practice/inject.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Render Dashboard once user is set, routing
// Get TODOs by user id
// Use riverpods to save todo state and update todos
// Dashboard UI
// Add todo w form -> update state -> dashboard update

void main() async {
  await injectDeps();

  // Wrap app in ProviderScope for access to riverpod state:
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Prac',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LandingScreen(),
    );
  }
}
