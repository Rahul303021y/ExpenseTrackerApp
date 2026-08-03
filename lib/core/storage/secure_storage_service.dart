import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _storage = FlutterSecureStorage();

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required int accessTokenExpiry,
  }) async {
    await _storage.write(
      key: 'access_token',
      value: accessToken,
    );

    await _storage.write(
      key: 'refresh_token',
      value: refreshToken,
    );

    await _storage.write(
      key: 'access_token_expiry',
      value: accessTokenExpiry.toString(),
    );
  }

  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

  Future<int?> getAccessTokenExpiry() async {
    final expiry = await _storage.read(
      key: 'access_token_expiry',
    );

    return expiry != null
        ? int.tryParse(expiry)
        : null;
  }

  Future<void> clear() async {
    await _storage.deleteAll();
  }
}