
class GetAllRewardDataModel {
  bool? success;
  String? message;
  String? error;
  List<RewardData>? data;
  int? results;

  GetAllRewardDataModel({
    this.success,
    this.message,
    this.error,
    this.data,
    this.results
  });

  factory GetAllRewardDataModel.fromJson(Map<String, dynamic> json) => GetAllRewardDataModel(
    success: json["Success"],
    message: json["Message"],
    results: json["Results"],
    error: json["Error"],
    data: json["Data"] == null ? [] : List<RewardData>.from(json["Data"]!.map((x) => RewardData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
    "Error": error,
    "Results": results,
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class RewardData {
  String? orderNumber;
  String? fileName;
  int? filePrice;
  int? reportsSubmitted;
  int? reportsApproved;
  int? votedReports;
  int? votedReportsApproved;
  double? currentBalance;

  RewardData({
    this.orderNumber,
    this.fileName,
    this.filePrice,
    this.reportsSubmitted,
    this.reportsApproved,
    this.votedReports,
    this.votedReportsApproved,
    this.currentBalance,
  });

  factory RewardData.fromJson(Map<String, dynamic> json) => RewardData(
    orderNumber: json["orderNumber"],
    fileName: json["fileName"],
    filePrice: json["filePrice"],
    reportsSubmitted: json["reportsSubmitted"],
    reportsApproved: json["reportsApproved"],
    votedReports: json["votedReports"],
    votedReportsApproved: json["votedReportsApproved"],
    currentBalance: json["currentBalance"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "orderNumber": orderNumber,
    "fileName": fileName,
    "filePrice": filePrice,
    "reportsSubmitted": reportsSubmitted,
    "reportsApproved": reportsApproved,
    "votedReports": votedReports,
    "votedReportsApproved": votedReportsApproved,
    "currentBalance": currentBalance,
  };
}
