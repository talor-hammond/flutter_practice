import 'package:flutter/material.dart';
import 'package:flutter_practice/models/todo.dart';
import 'package:flutter_practice/service/todo_service.dart';
import 'package:flutter_practice/service/user_service.dart';
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
    var user = ref.watch(userProvider).value!;
    var todos = ref.watch(todosProvider);

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
      body: todos.when(data: (data) {
        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome, ${user.name}",
                style:
                    const TextStyle(fontSize: 26, fontWeight: FontWeight.w500),
              ),
              const Padding(padding: EdgeInsets.only(top: 20)),
              Text(
                "TODAY'S TASKS",
                style: TextStyle(
                    color: Colors.blueGrey[300],
                    fontSize: 11,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500),
              ),
              _TodoList(todos: data)
            ],
          ),
        );
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }, error: (e, st) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}

class _TodoList extends StatelessWidget {
  const _TodoList({Key? key, required this.todos}) : super(key: key);

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    // TODO: Need to insertItem/removeItem programmatically for animation
    return AnimatedList(
        initialItemCount: todos.length,
        shrinkWrap: true,
        itemBuilder: (context, index, animation) {
          var todo = todos[index];

          return SlideTransition(
            position: animation.drive(
                Tween(begin: const Offset(-0.1, 0), end: const Offset(0, 0))),
            child: _TodoItem(
              todo: todo,
            ),
          );
        });
  }
}

class _TodoItem extends StatelessWidget {
  const _TodoItem({Key? key, required this.todo}) : super(key: key);

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(3))),
      child: Row(
        children: [
          Checkbox(
            value: todo.completed,
            onChanged: (value) {
              // Update riverpod store
            },
          ),
          Flexible(
              child: Text(
            todo.title,
            overflow: TextOverflow.fade,
            style: todo.completed
                ? TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.blueGrey[200])
                : null,
          ))
        ],
      ),
    );
  }
}
