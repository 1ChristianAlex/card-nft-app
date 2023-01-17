import 'package:card_nft_app/common/state/action_creator.dart';
import 'package:card_nft_app/common/state/app/app_state.dart';
import 'package:card_nft_app/common/state/deck/deck_reducer.dart';
import 'package:card_nft_app/common/state/deck/deck_state.dart';
import 'package:card_nft_app/common/state/user/user_reducer.dart';
import 'package:card_nft_app/common/state/user/user_state.dart';

AppState appReducer(AppState state, action) => AppState(
      user: action.payload is UserState
          ? userReducer(state.user, action as ActionCreator<UserState>)
          : state.user,
      deck: action.payload is DeckState
          ? deckReducer(state.deck, action as ActionCreator<DeckState>)
          : state.deck,
    );
