class UserModel {
  final String email;
  final String role;
  final String accessToken;
  final String refreshToken;
  final int    accessTokenExpiry;

  UserModel({
    required this.email,
    required this.role,
    required this.accessToken,
    required this.refreshToken,
    required this.accessTokenExpiry,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email:              json['email'],
      role:               json['role'],
      accessToken:        json['accessToken'],
      refreshToken:       json['refreshToken'],
      accessTokenExpiry:  json['accessTokenExpiry'],
    );
  }
}