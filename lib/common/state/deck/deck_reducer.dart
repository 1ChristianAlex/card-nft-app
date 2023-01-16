import 'package:card_nft_app/common/state/action_creator.dart';
import 'package:card_nft_app/common/state/deck/deck_actions.dart';
import 'package:card_nft_app/common/state/deck/deck_state.dart';

DeckState? deckReducer(DeckState? state, ActionCreator<DeckState> action) {
  switch (action.type) {
    case DeckActions.update:
      return action.payload;
    case DeckActions.remove:
      return null;
    default:
      return state;
  }
}
