import 'package:flutter/material.dart';
import 'package:flutter_practice/feature/landing/landing_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LandingScreen extends ConsumerWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var user = ref.watch(landingModel.select((value) => value.user));

    return Scaffold(
      body: user.when(
          data: (user) => Text(user.name),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (Object error, StackTrace? stackTrace) => const Text("Oops")),
    );
  }
}
