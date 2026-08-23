/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 18-08-2026 - 15:20
 * Product Name: Expenzo
 * ________________________________
 */
abstract class CommonEvent {
  const CommonEvent();
}

class CallApiEvent extends CommonEvent {
  CallApiEvent({required this.apiCall, this.isList = false});

  final Future<dynamic> Function() apiCall;
  final bool isList;
}

class ResetApiEvent extends CommonEvent {
  const ResetApiEvent();
}