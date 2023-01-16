import 'package:card_nft_app/common/http/http_adapter.dart';
import 'package:card_nft_app/common/http/http_adapter_model.dart';
import 'package:card_nft_app/features/dashboard/data/deck_model.dart';
import 'package:dio/dio.dart';

class DeckRepositorie {
  final HttpAdapter request;

  const DeckRepositorie(this.request);

  Future<Deck> getUserDeck() async {
    try {
      var response = await request.get('/deck/user', null, null);

      return Deck.fromJson(response.data);
    } on DioError catch (e) {
      throw ApiException.fromJson(e.response!.data);
    }
  }
}
