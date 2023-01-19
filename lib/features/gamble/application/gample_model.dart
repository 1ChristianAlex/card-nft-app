import 'package:card_nft_app/features/card/application/card_model.dart';

class GambleModel {
  final CardModel card;
  final DateTime? expiresIn;
  late final DateTime requestTime;

  GambleModel({required this.card, required this.expiresIn}) {
    requestTime = DateTime.now();
  }

  int diffInSeconds() {
    return expiresIn!.difference(requestTime).inSeconds;
  }

  int diffInSecondsByNow() {
    return expiresIn!.difference(DateTime.now()).inSeconds;
  }

  bool isExpired() {
    if (expiresIn != null) {
      var difference = expiresIn!.difference(DateTime.now());
      return difference.inSeconds <= 0;
    }

    return true;
  }
}
