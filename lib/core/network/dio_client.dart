import 'package:dio/dio.dart';
import 'package:expensetrackerapp/core/app_constants.dart';
import 'package:expensetrackerapp/core/storage/secure_storage_service.dart';

class DioClient {
  final Dio dio;
  final SecureStorageService storage;

  DioClient(this.storage)
      : dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        "Content-Type": "application/json",
      },
    ),
  ) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage.getAccessToken();

          if (token != null && token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }
          handler.next(options);
        },
      ),
    );
  }
}