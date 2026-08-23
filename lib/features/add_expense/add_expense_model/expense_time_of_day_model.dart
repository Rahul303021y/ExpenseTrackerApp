/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 22-08-2026 - 17:31
 * Product Name: Expenzo
 * ________________________________
 */

class ExpenseTimeOfDayModel {
  final int timeOfDayId;
  final String timeOfDayName;
  final String timeOfDayCode;

  ExpenseTimeOfDayModel(
      {required this.timeOfDayId,
      required this.timeOfDayName,
      required this.timeOfDayCode});

  factory ExpenseTimeOfDayModel.fromJson(Map<String, dynamic> json) {
    return ExpenseTimeOfDayModel(
        timeOfDayId: json['timeOfDayId'] as int,
        timeOfDayName: json['name']?.toString() ?? "",
        timeOfDayCode: json['code']?.toString() ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      'timeOfDayId': timeOfDayId,
      'name': timeOfDayName,
      'code': timeOfDayCode
    };
  }
}
