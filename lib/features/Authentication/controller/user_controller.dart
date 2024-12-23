import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/features/Authentication/model/user_model.dart';

part 'user_controller.g.dart';

@riverpod
class UserController extends _$UserController {
  @override
  UserModel? build() => null;

  void setUser(UserModel user) {
    state = user;
  }

  void clearUser() {
    state = null;
  }
}