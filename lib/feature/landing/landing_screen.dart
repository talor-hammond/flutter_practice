import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_practice/feature/dashboard/dashboard_screen.dart';
import 'package:flutter_practice/service/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingScreen extends ConsumerStatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  static const route = "landing";

  static PageRoute<void> create(RouteSettings routeSettings) {
    return MaterialPageRoute(builder: (context) {
      return const LandingScreen();
    });
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen> {
  @override
  void initState() {
    super.initState();

    _checkForUser();
  }

  Future<void> _checkForUser() async {
    try {
      final user = await ref.read(userProvider.future);

      SchedulerBinding.instance?.addPostFrameCallback((_) {
        Navigator.pushNamedAndRemoveUntil(
            context, DashboardScreen.route, (route) => route == null);
      });
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
