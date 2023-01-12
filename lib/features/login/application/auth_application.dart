import 'package:card_nft_app/common/http/http_adapter.dart';
import 'package:card_nft_app/common/http/http_adapter_model.dart';
import 'package:card_nft_app/common/storage/storage.dart.dart';
import 'package:card_nft_app/features/login/data/auth/auth_model.dart';
import 'package:card_nft_app/features/login/data/auth/auth_repo.dart';

class AuthAplication {
  final repo = AuthRepositorie(HttpAdapter(loadBearer: true));

  Future<AuthResponse> doLogin(String email, String password) async {
    var authResponse = await repo.login(email, password);

    await Storage().set(TOKEN_KEY, authResponse.token);
    return authResponse;
  }
}

AuthAplication authAplication() {
  return AuthAplication();
}
