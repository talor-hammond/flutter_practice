import 'package:dio/dio.dart';
import 'package:flutter_practice/service/todo_service.dart';
import 'package:flutter_practice/service/user_service.dart';
import 'package:flutter_practice/util/constants.dart';
import 'package:get_it/get_it.dart';

GetIt inject = GetIt.instance;

Future<void> injectDeps() async {
  // HTTP-client
  inject.registerSingleton(Dio(BaseOptions(baseUrl: apiUrl)));

  // Services
  inject.registerSingleton(UserService());
  inject.registerSingleton(TodoService());
}
