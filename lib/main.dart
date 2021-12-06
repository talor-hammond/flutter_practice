import 'package:flutter/material.dart';
import 'package:flutter_practice/feature/dashboard/dashboard_screen.dart';
import 'package:flutter_practice/feature/landing/landing_screen.dart';
import 'package:flutter_practice/inject.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Redirect to  Dashboard once user is set, routing
// Get TODOs by user id
// Use riverpods to save todo state and update todos
// Dashboard UI
// Add todo w form -> update state -> dashboard update

void main() async {
  await injectDeps();

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
      initialRoute: LandingScreen.route,
      onGenerateRoute: (routeSettings) {
        switch (routeSettings.name) {
          case DashboardScreen.route:
            return DashboardScreen.create(routeSettings);
          case LandingScreen.route:
          default:
            return LandingScreen.create(routeSettings);
        }
      },
    );
  }
}
