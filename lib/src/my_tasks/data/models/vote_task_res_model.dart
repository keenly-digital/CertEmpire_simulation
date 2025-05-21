
class VoteTaskResModel {
  bool? success;
  String? message;
  String? error;
  dynamic data;

  VoteTaskResModel({
    this.success,
    this.message,
    this.error,
    this.data,
  });

  factory VoteTaskResModel.fromJson(Map<String, dynamic> json) => VoteTaskResModel(
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
