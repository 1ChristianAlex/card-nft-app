class Deck {
  late final int id;
  late final int coins;
  late final int deckAmount;
  late final int claims;
  late final int gambles;
  late final DateTime nextGamble;
  DateTime? nextDaily;

  Deck({
    required this.id,
    required this.coins,
    required this.deckAmount,
    required this.claims,
    required this.gambles,
    required this.nextGamble,
    required this.nextDaily,
  });

  Deck.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    coins = json['coins'];
    deckAmount = json['deckAmount'];
    claims = json['claims'];
    gambles = json['gambles'];
    nextGamble = DateTime.parse(json['nextGamble']);
    nextDaily =
        json['nextDaily'] != null ? DateTime.parse(json['nextDaily']) : null;
  }
}
