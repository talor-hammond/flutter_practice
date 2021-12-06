import 'package:flutter/material.dart';
import 'package:flutter_practice/inject.dart';
import 'package:flutter_practice/models/user.dart';
import 'package:flutter_practice/service/user_service.dart';
import 'package:flutter_practice/util/safe_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// FutureProvider async'ly creates single value
// AsyncValue<X> = ref.watch(xProvider) abstracts loading state and data out of the box
final userProvider = FutureProvider<User>((ref) async {
  final userService = inject.get<UserService>();

  // hardcoded userId of 1
  final user = await userService.get(1);

  return user;
});

// This is the model watched by the landing_screen
final landingModel =
    ChangeNotifierProvider.autoDispose((ref) => LandingViewModel(ref));

// ViewModel is responsible for listening to the userProvider and providing updates
class LandingViewModel with ChangeNotifier, SafeNotifierMixin {
  AsyncValue<User> user = const AsyncValue.loading();

  LandingViewModel(AutoDisposeChangeNotifierProviderRef<LandingViewModel> ref) {
    // Get state of userProvider and re-evaluated when user state is updated
    final user = ref.watch(userProvider);

    // Set
    this.user = user;

    // Notify listeners
    notify();
  }
}
