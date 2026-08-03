import 'dart:convert';

import 'package:expensetrackerapp/features/login/login_model/login_user_model.dart';
import 'package:http/http.dart' as http;

import '../../../core/app_constants.dart';

class LoginApiProvider {
  Future<UserModel> login({
    required String email,
    required String password,
    required String deviceId,
    required String deviceName,
  }) async {
    final response = await http.post(
      Uri.parse('${AppConstants.baseUrl}/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'deviceId': deviceId,
        'deviceName': deviceName,
      }),
    );
    if (response.body.isEmpty) {
      throw Exception("Server returned empty response");
    }

    final json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return UserModel.fromJson(json['data']);
    }

    throw Exception(
      json['developerMessage'] ??
          json['message'] ??
          'Login failed',
    );
  }

  Future<UserModel> refreshToken({
    required String refreshToken,
    required String deviceId,
  }) async {
    final response = await http.post(
      Uri.parse('${AppConstants.baseUrl}/auth/refresh-token'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'refreshToken': refreshToken,
        'deviceId': deviceId,
      }),
    );

    if (response.body.isEmpty) {
      throw Exception("Server returned empty response");
    }

    final json = jsonDecode(response.body);

    if (response.statusCode == 200 && json['status'] == true) {
      return UserModel.fromJson(json['data']);
    }

    throw Exception(
      json['developerMessage'] ??
          json['message'] ??
          'Token refresh failed',
    );
  }
}
