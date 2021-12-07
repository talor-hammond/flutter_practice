import 'package:flutter_practice/models/todo.dart';
import 'package:flutter_practice/service/user_service.dart';
import 'package:flutter_practice/util/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class TodoService {
  Future<List<Todo>> get(num userId) async {
    try {
      var response =
          await dio.get("/todos", queryParameters: {"userId": userId});

      var todos = List<Todo>.from((response.data).map((t) => Todo.fromJson(t)));

      return todos;
    } catch (e) {
      throw Error();
    }
  }
}

// get, addd, update todos
final getTodosProvider = FutureProvider.autoDispose<List<Todo>>((ref) async {
  final todoService = GetIt.I.get<TodoService>();

  final user = ref.watch(userProvider);

  final userId = user.asData?.value.id;

  if (userId == null) {
    return [];
  }

  var todos = await todoService.get(userId);

  todos.sort((a, b) {
    if (a.completed) {
      return 1;
    }

    return -1;
  });

  return todos;
});

class TodosNotifier extends StateNotifier<AsyncValue<List<Todo>>> {
  TodosNotifier(this.read) : super(const AsyncValue.loading()) {
    _fetch();
  }

  final Reader read;

  Future<void> _fetch() async {
    state = await AsyncValue.guard(() {
      return read(getTodosProvider.future);
    });
  }

  void add(Todo todo) {
    state.whenData((todos) {
      state = AsyncValue.data([...todos, todo]);
    });
  }

  void complete(int id) {
    state.whenData((todos) {
      state = AsyncValue.data(todos.map((t) {
        if (t.id == id) {
          return Todo(
            completed: true,
            id: t.id,
            title: t.title,
            userId: t.userId,
          );
        }

        return t;
      }).toList());
    });
  }
}

final todosProvider =
    StateNotifierProvider<TodosNotifier, AsyncValue<List<Todo>>>((ref) {
  return TodosNotifier(ref.read);
});
