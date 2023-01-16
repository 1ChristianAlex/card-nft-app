import 'package:card_nft_app/features/dashboard/data/deck_model.dart';

class DeckState {
  late final int id;
  late final int coins;
  late final int deckAmount;
  late final int claims;
  late final int gambles;
  late final DateTime nextGamble;
  DateTime? nextDaily;

  DeckState({
    required this.id,
    required this.coins,
    required this.deckAmount,
    required this.claims,
    required this.gambles,
    required this.nextGamble,
    this.nextDaily,
  });

  DeckState.fromModel(Deck deckModel) {
    id = deckModel.id;
    coins = deckModel.coins;
    deckAmount = deckModel.deckAmount;
    claims = deckModel.claims;
    gambles = deckModel.gambles;
    nextGamble = (deckModel.nextGamble);
    nextDaily = deckModel.nextDaily;
  }
}
