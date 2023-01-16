import 'package:card_nft_app/common/state/action_creator.dart';
import 'package:card_nft_app/common/state/deck/deck_state.dart';
import 'package:card_nft_app/features/dashboard/data/deck_model.dart';

enum DeckActions {
  update(11),
  remove(22),
  ;

  final int code;

  const DeckActions(
    this.code,
  );

  String getUpperCaseName() {
    return name.toUpperCase();
  }
}

ActionCreator<DeckState> updateDeck(Deck deckModel) {
  return ActionCreator(
    type: DeckActions.update,
    payload: DeckState.fromModel(deckModel),
  );
}

ActionCreator<DeckState> removeDeck() {
  return ActionCreator<DeckState>(
    type: DeckActions.remove,
    payload: null,
  );
}
