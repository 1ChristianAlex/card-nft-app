import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  static Storage? instance;

  final storage = const FlutterSecureStorage();

  Storage() {
    Storage.instance ??= this;
  }

  Future<String?> get<T>(String key) async {
    String? value = await storage.read(key: key);

    return value;
  }

  Future<void> delete<T>(String key) async {
    await storage.delete(key: key);
  }

  Future<void> set(String key, String value) async {
    await storage.write(key: key, value: value);
  }
}
