import 'dart:convert';

import 'package:card_nft_app/common/http/http_adapter.dart';
import 'package:card_nft_app/common/http/http_adapter_model.dart';
import 'package:card_nft_app/features/card/application/card_model.dart';
import 'package:dio/dio.dart';

class GumbleRepositorie {
  final HttpAdapter request;

  const GumbleRepositorie(this.request);

  Future<Card> doGumble() async {
    try {
      var response = await request.get('/card/gamble', null, null);

      return Card.fromJson(response.data);
    } on DioError catch (e) {
      throw ApiException.fromJson(e.response!.data);
    }
  }

  Future<void> claim(int cardId) async {
    try {
      await request.post(
        '/deck/claim',
        jsonEncode({'id': cardId}),
      );
    } on DioError catch (e) {
      throw ApiException.fromJson(e.response!.data);
    }
  }
}
