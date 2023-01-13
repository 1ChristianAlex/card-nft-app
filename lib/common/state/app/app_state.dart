import 'package:card_nft_app/common/state/user/user_state.dart';

class AppState {
  UserState? user;

  AppState({this.user});

  static AppState initialState() {
    return AppState(user: null);
  }
}
