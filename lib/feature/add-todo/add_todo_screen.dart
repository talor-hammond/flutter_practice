import 'package:flutter/material.dart';
import 'package:flutter_practice/feature/add-todo/add_todo_form.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AddTodoScreen extends ConsumerWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  static const route = "add-todo";

  static PageRoute<void> create(RouteSettings routeSettings) {
    return MaterialPageRoute(
      builder: (context) {
        return const AddTodoScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formGroup = ref.read(formGroupProvider);
    final addTodoModel = ref.read(addTodoProvider);

    return Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.blueGrey[300]),
          leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.alarm))
          ],
        ),
        body: ReactiveForm(
          formGroup: formGroup,
          child: Column(
            children: [
              ReactiveTextField(
                formControlName: "title",
              ),
              ReactiveFormConsumer(builder: (context, form, child) {
                return TextButton(
                    onPressed: form.valid
                        ? () {
                            addTodoModel.submit();
                          }
                        : null,
                    child: const Text("Add"));
              })
            ],
          ),
        ));
  }
}
