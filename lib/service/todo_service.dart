import 'package:flutter_practice/models/todo.dart';
import 'package:flutter_practice/util/api.dart';

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
