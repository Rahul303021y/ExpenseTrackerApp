import 'package:dio/dio.dart';

class HomeScreenApiProvider {
  final Dio dio;

  HomeScreenApiProvider(this.dio);

  Future<Response> getExpenses() {
    return dio.post(
      "/expense/get-all-expenses",
      data: {
        "maxResults": 10,
        "pageNum": 1,
        "sortBy": "",
      },
    );
  }
}