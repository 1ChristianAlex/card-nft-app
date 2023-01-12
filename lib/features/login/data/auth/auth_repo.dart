import 'dart:convert';

import 'package:card_nft_app/common/http/http_adapter.dart';
import 'package:card_nft_app/features/login/data/auth/auth_model.dart';

class AuthRepo {
  final HttpAdapter request;

  const AuthRepo(this.request);

  Future<AuthResponse> login(String email, String password) async {
    var json = AuthBody(email: email, password: password).toJson();
    var response =
        await request.post('/auth/login', jsonEncode(json), null, null);

    return AuthResponse.fromJson(jsonDecode(response.body));
  }
}
