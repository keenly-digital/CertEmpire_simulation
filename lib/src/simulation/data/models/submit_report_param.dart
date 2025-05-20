
class SubmitQuestionReportParam {
  int? type;
  int? targetId;
  String? reason;
  String? explanation;
  String? userId;
  String? fileId;
  String? questionNumber;


  SubmitQuestionReportParam({
    this.type,
    this.targetId,
    this.reason,
    this.explanation,
    this.userId,
    this.fileId,
    this.questionNumber,
  });

  factory SubmitQuestionReportParam.fromJson(Map<String, dynamic> json) => SubmitQuestionReportParam(
    type: json["type"],
    targetId: json["targetId"],
    reason: json["reason"],
    explanation: json["explanation"],
    userId: json["userId"],
    fileId: json["fileId"],
    questionNumber: json["questionNumber"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "targetId": targetId,
    "reason": reason,
    "explanation": explanation,
    "userId": userId,
    "fileId": fileId,
    "questionNumber": questionNumber,
  };
}
