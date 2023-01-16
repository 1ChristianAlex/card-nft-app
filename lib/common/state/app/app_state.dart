import 'package:card_nft_app/common/state/deck/deck_state.dart';
import 'package:card_nft_app/common/state/user/user_state.dart';

class AppState {
  UserState? user;
  DeckState? deck;

  AppState({this.user, this.deck});

  static AppState initialState() {
    return AppState(user: null, deck: null);
  }
}
