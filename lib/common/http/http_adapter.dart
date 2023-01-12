import 'package:card_nft_app/common/storage/storage.dart.dart';
import 'package:http/http.dart' as http;

class HttpAuthClient extends http.BaseClient {
  late final bool useAuth;
  HttpAuthClient(this.useAuth);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (useAuth) {
      String? token = await Storage().get('Bearer');

      // intercept each call and add the Authorization header if token is available
      if (token != null && token.isNotEmpty) {
        request.headers.putIfAbsent('Authorization', () => 'Bearer $token');
      }
    }

    request.headers.addAll({'content-type': 'application/json; charset=UTF-8'});

    return request.send();
  }
}

class HttpAdapter {
  String host = '192.168.0.165:3000';
  late final http.Client instance;

  HttpAdapter({
    String? domain,
    bool loadBearer = true,
  }) {
    if (domain != null && domain.isNotEmpty) {
      host = domain;
    }

    instance = HttpAuthClient(loadBearer);
  }

  Future<http.Response> get(
    String route,
    Map<String, String>? paramns,
    Map<String, String>? headers,
  ) {
    return instance.get(
      Uri.http(host, route, paramns),
      headers: headers,
    );
  }

  Future<http.Response> post(
    String route,
    Object? body,
    Map<String, String>? paramns,
    Map<String, String>? headers,
  ) {
    var uri = Uri.http(host, route, paramns);
    return instance.post(
      uri,
      headers: headers,
      body: body,
    );
  }
}
