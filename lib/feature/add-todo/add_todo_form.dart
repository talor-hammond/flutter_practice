import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter_practice/models/todo.dart';
import 'package:flutter_practice/service/todo_service.dart';
import 'package:flutter_practice/service/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

// provides the form group obj
final formGroupProvider = Provider.autoDispose<FormGroup>((ref) {
  return FormGroup({
    "title": FormControl<String>(value: "", validators: [Validators.required])
  });
});

// provides a change notifier (to a widget)
final addTodoProvider = ChangeNotifierProvider<AddTodoViewModel>((ref) {
  return AddTodoViewModel(ref);
});

class AddTodoViewModel extends ChangeNotifier {
  AddTodoViewModel(this.ref) : super() {
    formGroup = ref.read(formGroupProvider);
  }

  bool isSubmitting = false;

  final ChangeNotifierProviderRef ref;
  late FormGroup formGroup;

  Future<void> submit() {
    isSubmitting = true;
    notifyListeners();

    final userId =
        ref.watch(userProvider.select((value) => value.asData?.value.id))!;
    final todosNotifier = ref.read(todosProvider.notifier);
    String todoTitle = formGroup.control("title").value;

    final rng = Random();

    final newTodo = Todo(
        completed: false,
        userId: userId,
        id: rng.nextInt(10000),
        title: todoTitle);

    return Future.delayed(const Duration(seconds: 2), () {
      todosNotifier.add(newTodo);
    }).then((value) {
      isSubmitting = false;
      notifyListeners();
    });
  }
}
