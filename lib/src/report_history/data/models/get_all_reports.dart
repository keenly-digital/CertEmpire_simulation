// To parse this JSON data, do
//
//     final getAllReportsModel = getAllReportsModelFromJson(jsonString);

import 'dart:convert';

GetAllReportsModel getAllReportsModelFromJson(String str) => GetAllReportsModel.fromJson(json.decode(str));

String getAllReportsModelToJson(GetAllReportsModel data) => json.encode(data.toJson());

class GetAllReportsModel {
  bool? success;
  String? message;
  String? error;
  Data? data;

  GetAllReportsModel({
    this.success,
    this.message,
    this.error,
    this.data,
  });

  factory GetAllReportsModel.fromJson(Map<String, dynamic> json) => GetAllReportsModel(
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
  int? results;
  List<ReportData>? data;

  Data({
    this.results,
    this.data,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    results: json["results"],
    data: json["data"] == null ? [] : List<ReportData>.from(json["data"]!.map((x) => ReportData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "results": results,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
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
