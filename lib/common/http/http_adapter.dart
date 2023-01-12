import 'package:card_nft_app/common/http/http_adapter_model.dart';
import 'package:card_nft_app/common/jwt_manager/jwt_manager.dart';
import 'package:dio/dio.dart';

class HttpAdapter {
  String host = '192.168.0.165:3000';
  late final instance = Dio();

  HttpAdapter({
    String? domain,
    bool loadBearer = true,
  }) {
    if (domain != null && domain.isNotEmpty) {
      host = domain;
    }

    if (loadBearer) {
      instance.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await JWTManager().get();

          // intercept each call and add the Authorization header if token is available
          if (token != null && token.isNotEmpty) {
            options.headers
                .putIfAbsent('Authorization', () => '$TOKEN_KEY $token');
          }

          return handler.next(options);
        },
      ));
    }
  }

  Future<Response<T>> get<T>(
    String route,
    Map<String, String>? paramns,
    Map<String, String>? headers,
  ) {
    try {
      return instance.getUri<T>(Uri.http(host, route, paramns),
          options: Options(headers: headers));
    } on DioError {
      rethrow;
    }
  }

  Future<Response<T>> post<T>(String route, dynamic body,
      {Map<String, String>? paramns, Map<String, String>? headers}) {
    try {
      return instance.postUri<T>(Uri.http(host, route, paramns),
          options: Options(headers: headers), data: body);
    } on DioError {
      rethrow;
    }
  }

  Future<Response<T>> put<T>(String route, dynamic body,
      {Map<String, String>? paramns, Map<String, String>? headers}) {
    try {
      return instance.putUri<T>(Uri.http(host, route, paramns),
          options: Options(headers: headers), data: body);
    } on DioError {
      rethrow;
    }
  }

  Future<Response<T>> delete<T>(String route, dynamic body,
      {Map<String, String>? paramns, Map<String, String>? headers}) {
    try {
      return instance.deleteUri<T>(Uri.http(host, route, paramns),
          options: Options(headers: headers), data: body);
    } on DioError {
      rethrow;
    }
  }
}
