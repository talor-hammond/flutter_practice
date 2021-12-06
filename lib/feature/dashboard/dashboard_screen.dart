import 'package:flutter/material.dart';
import 'package:flutter_practice/feature/dashboard/dashboard_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends ConsumerWidget {
  static const route = "/";

  static PageRoute<void> create(RouteSettings routeSettings) {
    return MaterialPageRoute(builder: (context) {
      return const DashboardScreen();
    });
  }

  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var dashboard = ref.watch(dashboardModel);

    return Scaffold(
      body: Builder(builder: (context) {
        if (dashboard.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (dashboard.isError) {
          return const Center(child: Text("Oops"));
        }

        return Center(child: Text("Welcome ${dashboard.user.value?.name}"));
      }),
    );
  }
}
