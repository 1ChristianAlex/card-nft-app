import 'package:card_nft_app/common/state/action_creator.dart';
import 'package:card_nft_app/common/state/user/user_actions.dart';
import 'package:card_nft_app/common/state/user/user_state.dart';

UserState? userReducer(UserState? state, ActionCreator<UserState> action) {
  switch (action.type) {
    case UserActions.update:
      return action.payload;
    case UserActions.remove:
      return null;
    default:
      return state;
  }
}
