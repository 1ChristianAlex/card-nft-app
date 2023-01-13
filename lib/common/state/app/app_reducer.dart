import 'package:card_nft_app/common/state/app/app_state.dart';
import 'package:card_nft_app/common/state/user/user_reducer.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    user: userReducer(state.user, action),
  );
}
