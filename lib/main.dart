import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/feature/dashboard/dashboard_screen.dart';
import 'package:flutter_practice/inject.dart';
import 'package:flutter_practice/util/constants.dart';

// Get user by id (1)
// Save user to state
// Render Dashboard once user is set
// Get TODOs by user id
// Use riverpods to save todo state and update todos

void main() async {
  await injectDeps();

  // HTTP client setup:
  Dio(BaseOptions(baseUrl: apiUrl));

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

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
