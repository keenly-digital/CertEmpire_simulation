
class SubmitQuestionReportModel {
  bool? success;
  String? message;
  String? error;
  dynamic data;

  SubmitQuestionReportModel({
    this.success,
    this.message,
    this.error,
    this.data,
  });

  factory SubmitQuestionReportModel.fromJson(Map<String, dynamic> json) => SubmitQuestionReportModel(
    success: json["Success"],
    message: json["Message"],
    error: json["Error"],
    data: json["Data"],
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
    "Error": error,
    "Data": data,
  };
}
