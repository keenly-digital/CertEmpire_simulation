class VoteTaskParamModel {
  String? taskId;
  String? decision;
  String? explanation;

  VoteTaskParamModel({
    this.taskId,
    this.decision,
    this.explanation,
  });

  factory VoteTaskParamModel.fromJson(Map<String, dynamic> json) => VoteTaskParamModel(
    taskId: json["taskId"],
    decision: json["decision"],
    explanation: json["explanation"],
  );

  Map<String, dynamic> toJson() => {
    "taskId": taskId,
    "decision": decision,
    "explanation": explanation,
  };
}
