import 'package:dio/dio.dart';
import 'package:flutter_practice/models/user.dart';

class UserService {
  Future<User> getUser(num userId) async {
    try {
      // TODO: Access Dio via getIt
      var response = await Dio().get("/users", queryParameters: {"id": userId});

      var user = User.fromJson(response.data);
      print(user);

      return user;
    } catch (e) {
      throw Error();
    }
  }
}
