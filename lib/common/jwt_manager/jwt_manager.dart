import 'package:card_nft_app/common/http/http_adapter_model.dart';
import 'package:card_nft_app/common/jwt_manager/jwt_manager_model.dart';
import 'package:card_nft_app/common/storage/storage.dart.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class JWTManager {
  final _storage = Storage();

  Future<void> set(String token) async {
    await _storage.set(TOKEN_KEY, token);
  }

  Future<String?> get() async {
    var token = await _storage.get(TOKEN_KEY);

    return token;
  }

  Future<JWTDecoded> decode() async {
    var token = await get();

    if (token == null) {
      throw Exception('Token não existe');
    }
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    return JWTDecoded.fromJson(decodedToken);
  }

  Future<bool> isAuth() async {
    var token = await get();

    if (token == null) {
      return false;
    }
    return !JwtDecoder.isExpired(token);
  }
}
