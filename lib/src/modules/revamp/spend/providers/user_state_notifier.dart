import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rex_app/src/modules/revamp/utils/data/rex_api/rex_api.dart';

class UserStateNotifier extends StateNotifier<LoginResponseData> {
  UserStateNotifier() : super(LoginResponseData());

  void updateUser({required LoginResponseData user}) {
    state = user;
  }

  Future<LoginResponseData> getUser() {
    return Future.value(state);
  }
}

final userStateNotifierProvider =
    StateNotifierProvider<UserStateNotifier, LoginResponseData>((ref) {
  return UserStateNotifier();
});
