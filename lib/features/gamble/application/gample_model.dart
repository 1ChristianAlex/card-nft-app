import 'package:card_nft_app/features/card/application/card_model.dart';

class GambleModel {
  final CardModel card;
  final int? expiresInSeconds;
  late final DateTime expiresIn;

  GambleModel({required this.card, required this.expiresInSeconds}) {
    expiresIn = DateTime.now().add(Duration(seconds: expiresInSeconds ?? 0));
  }

  Duration diffNow() {
    return expiresIn.difference(DateTime.now());
  }

  bool isExpired() {
    if (expiresInSeconds != null) {
      return diffNow().isNegative;
    }

    return true;
  }
}
