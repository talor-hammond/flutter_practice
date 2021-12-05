import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_practice/models/todo.dart';

class TodoService {
  Future<List<Todo>> getTodos(num userId) async {
    try {
      var response =
          await Dio().get("/todos", queryParameters: {"userId": userId});

      var todos = List<Todo>.from(
          (jsonDecode(response.data) as List).map((t) => Todo.fromJson(t)));

      return todos;
    } catch (e) {
      throw Error();
    }
  }
}
