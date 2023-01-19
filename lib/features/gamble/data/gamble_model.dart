import 'package:card_nft_app/features/card/application/card_model.dart';

class GambleResponse {
  late final CardModel? card;
  late final DateTime? expiresIn;

  GambleResponse({this.card, this.expiresIn});

  GambleResponse.fromJson(Map<String, dynamic> json) {
    card = CardModel.fromJson(json['card']);
    expiresIn = DateTime.parse(json['expiresIn']);
  }
}
