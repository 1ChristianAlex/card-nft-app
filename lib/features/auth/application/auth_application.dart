import 'package:card_nft_app/common/http/http_adapter.dart';
import 'package:card_nft_app/common/jwt_manager/jwt_manager.dart';
import 'package:card_nft_app/features/auth/application/auth_view_model.dart';
import 'package:card_nft_app/features/auth/data/auth/auth_model.dart';
import 'package:card_nft_app/features/auth/data/auth/auth_repo.dart';

class AuthAplication {
  final repo = AuthRepositorie(HttpAdapter(loadBearer: true));

  Future<AuthResponse> doLogin(String email, String password) async {
    var authResponse = await repo.login(email, password);

    await JWTManager().set(authResponse.token);
    return authResponse;
  }

  Future<UserRegisterResponse> register(NewUserModel register) async {
    var userRegister = await repo.register(register);

    return userRegister;
  }
}

AuthAplication authAplication() {
  return AuthAplication();
}
