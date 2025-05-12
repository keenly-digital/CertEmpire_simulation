
class GetAllReportsModel {
  bool? success;
  String? message;
  String? error;
  int? results;

  List<ReportData>? data;

  GetAllReportsModel({
    this.success,
    this.message,
    this.error,
    this.data,
    this.results,
  });

  factory GetAllReportsModel.fromJson(Map<String, dynamic> json) => GetAllReportsModel(
    success: json["Success"],
    message: json["Message"],
    results: json["results"],
    error: json["Error"],
    data: json["Data"] == null ? [] : List<ReportData>.from(json["Data"]!.map((x) => ReportData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
    "results": results,
    "Error": error,
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class ReportData {
  String? id;
  String? reportName;
  String? examName;
  String? status;

  ReportData({
    this.id,
    this.reportName,
    this.examName,
    this.status,
  });

  factory ReportData.fromJson(Map<String, dynamic> json) => ReportData(
    id: json["id"],
    reportName: json["reportName"],
    examName: json["examName"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reportName": reportName,
    "examName": examName,
    "status": status,
  };
}
