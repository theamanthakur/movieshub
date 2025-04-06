import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  static const String _accessTokenKey = 'accessTokenfss';
  static const String _refreshTokenKey = 'refreshTokenfss';

  final storage = const FlutterSecureStorage();

  Future<void> saveAccessToken(String token) async {
    await storage.write(key: _accessTokenKey, value: token);
  }

  Future<String?> readAccessToken() async {
    return await storage.read(key: _accessTokenKey);
  }

  Future<void> saveRefreshToken(String token) async {
    await storage.write(key: _refreshTokenKey, value: token);
  }

  Future<String?> readRefreshToken() async {
    return await storage.read(key: _refreshTokenKey);
  }

  Future<void> clearTokens() async {
    await storage.deleteAll();
  }
}
