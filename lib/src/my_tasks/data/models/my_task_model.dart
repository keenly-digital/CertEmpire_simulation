// To parse this JSON data, do
//
//     final getAllTaskModel = getAllTaskModelFromJson(jsonString);

import 'dart:convert';

GetAllTaskModel getAllTaskModelFromJson(String str) => GetAllTaskModel.fromJson(json.decode(str));

String getAllTaskModelToJson(GetAllTaskModel data) => json.encode(data.toJson());

class GetAllTaskModel {
  bool? success;
  String? message;
  String? error;
  List<TaskItem>? data;

  GetAllTaskModel({
    this.success,
    this.message,
    this.error,
    this.data,
  });

  factory GetAllTaskModel.fromJson(Map<String, dynamic> json) => GetAllTaskModel(
    success: json["Success"],
    message: json["Message"],
    error: json["Error"],
    data: json["Data"] == null ? [] : List<TaskItem>.from(json["Data"]!.map((x) => TaskItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
    "Error": error,
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class TaskItem {
  String? taskId;
  String? examName;
  String? questionId;
  String? questionContent;
  List<int>? currentAnswer;
  String? currentExplanation;
  List<dynamic>? suggestedAnswer;
  String? suggestedExplanation;
  String? reportType;
  String? requestedAt;
  String? reason;
  String? questionNumber;

  TaskItem({
    this.taskId,
    this.examName,
    this.questionId,
    this.questionContent,
    this.currentAnswer,
    this.currentExplanation,
    this.suggestedAnswer,
    this.suggestedExplanation,
    this.reportType,
    this.requestedAt,
    this.reason,
    this.questionNumber,
  });

  factory TaskItem.fromJson(Map<String, dynamic> json) => TaskItem(
    taskId: json["taskId"],
    examName: json["examName"],
    questionId: json["questionId"],
    questionContent: json["questionContent"],
    currentAnswer: json["currentAnswer"] == null ? [] : List<int>.from(json["currentAnswer"]!.map((x) => x)),
    currentExplanation: json["currentExplanation"],
    suggestedAnswer: json["suggestedAnswer"] == null ? [] : List<dynamic>.from(json["suggestedAnswer"]!.map((x) => x)),
    suggestedExplanation: json["suggestedExplanation"],
    reportType: json["reportType"],
    requestedAt: json["requestedAt"],
    reason: json["reason"],
    questionNumber: json["questionNumber"],
  );

  Map<String, dynamic> toJson() => {
    "taskId": taskId,
    "examName": examName,
    "questionId": questionId,
    "questionContent": questionContent,
    "currentAnswer": currentAnswer == null ? [] : List<dynamic>.from(currentAnswer!.map((x) => x)),
    "currentExplanation": currentExplanation,
    "suggestedAnswer": suggestedAnswer == null ? [] : List<dynamic>.from(suggestedAnswer!.map((x) => x)),
    "suggestedExplanation": suggestedExplanation,
    "reportType": reportType,
    "requestedAt": requestedAt,
    "reason": reason,
    "questionNumber": questionNumber,
  };
}
