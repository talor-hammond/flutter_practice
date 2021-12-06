import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_practice/feature/dashboard/dashboard_screen.dart';
import 'package:flutter_practice/feature/landing/landing_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingScreen extends ConsumerWidget {
  static const route = "/landing";

  static PageRoute<void> create(RouteSettings routeSettings) {
    return MaterialPageRoute(builder: (context) {
      return const LandingScreen();
    });
  }

  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(landingModel.select((value) => value.user));

    return Scaffold(
      body: user.when(
          data: (user) {
            // Redirect to Dashboard when user data is there
            // This pattern should be driven by the the main/App but wanted to experiment w/ ChangeNotifierProvider in the landing view model
            SchedulerBinding.instance?.addPostFrameCallback((_) {
              Navigator.pushReplacementNamed(context, DashboardScreen.route);
            });
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (Object error, StackTrace? stackTrace) =>
              const Text("Couldn't retrieve user")),
    );
  }
}
