import 'package:dio/dio.dart';
import 'package:flutter_practice/service/user_service.dart';
import 'package:get_it/get_it.dart';

Future<void> injectDeps() async {
  // Services
  GetIt.I.registerSingleton(UserService());
}
