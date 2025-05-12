
class ViewReportReason {
  bool? success;
  String? message;
  String? error;
  Data? data;

  ViewReportReason({
    this.success,
    this.message,
    this.error,
    this.data,
  });

  factory ViewReportReason.fromJson(Map<String, dynamic> json) => ViewReportReason(
    success: json["Success"],
    message: json["Message"],
    error: json["Error"],
    data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
    "Error": error,
    "Data": data?.toJson(),
  };
}

class Data {
  String? examName;
  String? status;
  String? explanation;

  Data({
    this.examName,
    this.status,
    this.explanation,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    examName: json["examName"],
    status: json["status"],
    explanation: json["explanation"],
  );

  Map<String, dynamic> toJson() => {
    "examName": examName,
    "status": status,
    "explanation": explanation,
  };
}
