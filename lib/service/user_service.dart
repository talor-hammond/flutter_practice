import 'package:flutter_practice/models/user.dart';
import 'package:flutter_practice/util/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../inject.dart';

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

final userProvider = FutureProvider<User>((ref) async {
  final userService = inject.get<UserService>();

  // hardcoded userId of 1
  final user = await userService.get(1);

  return user;
});
