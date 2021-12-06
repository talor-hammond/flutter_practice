import 'package:dio/dio.dart';
import 'package:flutter_practice/inject.dart';
import 'package:flutter_practice/models/user.dart';

class UserService {
  Future<User> get(num userId) async {
    try {
      var response = await inject
          .get<Dio>()
          .get("/users", queryParameters: {"id": userId});

      var user = User.fromJson(response.data[0]);

      return user;
    } catch (e) {
      throw Error();
    }
  }
}
