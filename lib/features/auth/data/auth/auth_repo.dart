import 'dart:convert';

import 'package:card_nft_app/common/http/http_adapter.dart';
import 'package:card_nft_app/common/http/http_adapter_model.dart';
import 'package:card_nft_app/features/auth/application/auth_view_model.dart';
import 'package:card_nft_app/features/auth/data/auth/auth_model.dart';
import 'package:dio/dio.dart';

class AuthRepositorie {
  final HttpAdapter request;

  const AuthRepositorie(this.request);

  Future<AuthResponse> login(String email, String password) async {
    try {
      var json = AuthBody(email: email, password: password).toJson();
      var response = await request.post(
        '/auth/login',
        jsonEncode(json),
      );

      return AuthResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw ApiException.fromJson(e.response!.data);
    }
  }

  Future<UserRegisterResponse> register(NewUserModel body) async {
    try {
      var response = await request.post(
        '/users',
        jsonEncode(
          NewUserBody(
            email: body.email,
            lastName: body.lastName,
            name: body.name,
            password: body.password,
          ).toJson(),
        ),
      );

      return UserRegisterResponse.fromJson(response.data);
    } on DioError catch (e) {
      throw ApiException.fromJson(e.response!.data);
    }
  }
}
