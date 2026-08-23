/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 18-08-2026 - 15:35
 * Product Name: Expenzo
 * ________________________________
 */

import 'api_status.dart';

class CommonState {
  const CommonState({this.apiStatus = const ApiInitialState()});
  final ApiStatus apiStatus;

  CommonState copyWith({ApiStatus? apiStatus}) {
    return CommonState(apiStatus: apiStatus ?? this.apiStatus);
  }
}