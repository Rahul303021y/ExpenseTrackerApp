/*
 * _______________________________
 * Created By: Rahul Kumar
 * Created At: 24-08-2026 - 17:44
 * Product Name: Expenzo
 * ________________________________
 */

class ExpenseAttachment {
  final String uuid;
  final String fileName;
  final String fileType;
  final int fileSize;

  ExpenseAttachment({
    required this.uuid,
    required this.fileName,
    required this.fileType,
    required this.fileSize,
  });

  factory ExpenseAttachment.fromJson(Map<String, dynamic> json) {
    return ExpenseAttachment(
      uuid: json["uuid"],
      fileName: json["fileName"],
      fileType: json["fileType"],
      fileSize: json["fileSize"],
    );
  }

  bool get isImage => fileType.toLowerCase() == "jpg" || fileType.toLowerCase() == "jpeg" || fileType.toLowerCase() == "png";
  bool get isPdf => fileType.toLowerCase() == "pdf";
}