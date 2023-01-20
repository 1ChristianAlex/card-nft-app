import 'package:card_nft_app/features/card/application/card_model.dart';

class GambleResponse {
  late final CardModel? card;
  late final int? expiresInSeconds;

  GambleResponse({this.card, this.expiresInSeconds});

  GambleResponse.fromJson(Map<String, dynamic> json) {
    card = CardModel.fromJson(json['card']);
    expiresInSeconds = json['expiresInSeconds'];
  }
}
