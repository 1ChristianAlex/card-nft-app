class ApiException implements Exception {
  late int statusCode;
  late String message;

  ApiException({required this.statusCode, required this.message});

  ApiException.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    data['message'] = message;
    return data;
  }

  @override
  String toString() {
    return message;
  }
}

// ignore: constant_identifier_names
const String TOKEN_KEY = 'Bearer';
