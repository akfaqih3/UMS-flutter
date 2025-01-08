import 'package:lecture_2/helpers/cache.dart';

class TokenStorage {
  static const String _accessTokenKey = 'accessToken';
  static const String _refreshTokenKey = 'refreshToken';

  static Future<void> saveToken(String accessToken, String refreshToken) async {
    await Cache.setString(_accessTokenKey, accessToken);
    await Cache.setString(_refreshTokenKey, refreshToken);
  }

  static Future<void> clearToken() async {
    await Cache.remove(_accessTokenKey);
    await Cache.remove(_refreshTokenKey);
  }

  static Future<String?> getAccessToken() async {
    return await Cache.getString(_accessTokenKey);
  }

  static Future<String?> getRefreshToken() async {
    return await Cache.getString(_refreshTokenKey);
  }
}
