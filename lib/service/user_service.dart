import 'package:flutter_practice/models/user.dart';
import 'package:flutter_practice/util/api.dart';

class UserService {
  Future<User> get(num userId) async {
    try {
      var response = await dio.get("/users", queryParameters: {"id": userId});

      var user = User.fromJson(response.data[0]);

      return user;
    } catch (e) {
      throw Error();
    }
  }
}
