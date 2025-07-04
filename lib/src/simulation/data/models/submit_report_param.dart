class SubmitQuestionReportParam {
  String? type;
  int? targetId;
  String? reason;
  String? explanation;
  String? userId;
  String? fileId;
  String? questionNumber;
  int? orderId;

  SubmitQuestionReportParam({
    this.type,
    this.targetId,
    this.reason,
    this.explanation,
    this.userId,
    this.fileId,
    this.questionNumber,
    required this.orderId,
  });

  factory SubmitQuestionReportParam.fromJson(Map<String, dynamic> json) =>
      SubmitQuestionReportParam(
        type: json["type"],
        targetId: json["targetId"],
        reason: json["reason"],
        explanation: json["explanation"],
        userId: json["userId"],
        fileId: json["fileId"],
        questionNumber: json["questionNumber"],
        orderId: json["orderId"],
      );

  Map<String, dynamic> toJson() => {
    "type": type,
    "targetId": targetId,
    "reason": reason,
    "explanation": explanation,
    "userId": userId,
    "fileId": fileId,
    "questionNumber": questionNumber,
    "orderId": orderId,
  };
}
