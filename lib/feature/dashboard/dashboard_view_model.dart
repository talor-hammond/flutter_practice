import 'package:flutter/material.dart';
import 'package:flutter_practice/feature/landing/landing_view_model.dart';
import 'package:flutter_practice/models/todo.dart';
import 'package:flutter_practice/models/user.dart';
import 'package:flutter_practice/service/todo_service.dart';
import 'package:flutter_practice/util/safe_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

final _userIdProvider = FutureProvider<int>((ref) async {
  final user = await ref.watch(userProvider.future);

  return user.id;
});

final todosProvider = FutureProvider<List<Todo>>((ref) async {
  final todoService = GetIt.I.get<TodoService>();

  final userId = await ref.watch(_userIdProvider.future);

  final todos = await todoService.get(userId);

  return todos;

  // this provider be updated to provide filtering + adding of todos?
});

final dashboardModel =
    ChangeNotifierProvider.autoDispose((ref) => DashboardViewModel(ref));

// TODO: dashboardProvider which wraps the data we need up into one AsyncValue
class DashboardViewModel with ChangeNotifier, SafeNotifierMixin {
  AsyncValue<User> user = const AsyncValue.loading();
  AsyncValue<List<Todo>> todos = const AsyncValue.loading();

  bool isLoading = true;
  bool isError = false;

  DashboardViewModel(Ref ref) {
    final user = ref.watch(userProvider.select((user) => user));
    final todos = ref.watch(todosProvider);

    this.user = user;
    this.todos = todos;

    this.isLoading = this.user is AsyncLoading || this.todos is AsyncLoading;
    this.isError = this.user is AsyncError || this.todos is AsyncError;

    notify();
  }
}
