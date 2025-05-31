
class GetCouponModel {
  bool? success;
  String? message;
  String? error;
  dynamic data;

  GetCouponModel({
    this.success,
    this.message,
    this.error,
    this.data,
  });

  factory GetCouponModel.fromJson(Map<String, dynamic> json) => GetCouponModel(
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
