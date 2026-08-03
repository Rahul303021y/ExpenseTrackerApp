import 'package:expensetrackerapp/core/storage/secure_storage_service.dart';

import '../login_model/login_user_model.dart';
import 'login_api_provider.dart';

class LoginRepo {
  final LoginApiProvider apiProvider;
  final SecureStorageService storage;

  LoginRepo(this.apiProvider, this.storage,);

  Future<UserModel> login({
    required String email,
    required String password,
    required String deviceId,
    required String deviceName,
  }) async {

    final user = await apiProvider.login(
      email: email,
      password: password,
      deviceId: deviceId,
      deviceName: deviceName,
    );

    await storage.saveTokens(
      accessToken: user.accessToken,
      refreshToken: user.refreshToken,
      accessTokenExpiry: user.accessTokenExpiry
    );

    return user;
  }
}