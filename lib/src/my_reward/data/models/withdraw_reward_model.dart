
class WithdrawRewardModel {
  bool? success;
  String? message;
  String? error;
  double? data;

  WithdrawRewardModel({
    this.success,
    this.message,
    this.error,
    this.data,
  });

  factory WithdrawRewardModel.fromJson(Map<String, dynamic> json) => WithdrawRewardModel(
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
