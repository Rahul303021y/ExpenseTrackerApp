class ApiResponse<T> {
  final bool status;
  final String developerMessage;
  final T data;

  ApiResponse({
    required this.status,
    required this.developerMessage,
    required this.data,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) {
    return ApiResponse(
      status: json['status'],
      developerMessage: json['developerMessage'],
      data: fromJsonT(json['data']),
    );
  }
}