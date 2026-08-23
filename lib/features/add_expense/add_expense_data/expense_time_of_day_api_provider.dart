/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 22-08-2026 - 17:28
 * Product Name: Expenzo
 * ________________________________
 */

import 'package:dio/dio.dart';

class ExpenseTimeOfDayApiProvider{
  final Dio dio;
  ExpenseTimeOfDayApiProvider(this.dio);
  Future<Response> fetchAllTimeOfDay(){
    return dio.get("/time-of-day");
  }
}