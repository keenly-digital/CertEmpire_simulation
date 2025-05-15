
class GetAllRewardDataModel {
  bool? success;
  String? message;
  String? error;
  List<RewardData>? data;

  GetAllRewardDataModel({
    this.success,
    this.message,
    this.error,
    this.data,
  });

  factory GetAllRewardDataModel.fromJson(Map<String, dynamic> json) => GetAllRewardDataModel(
    success: json["Success"],
    message: json["Message"],
    error: json["Error"],
    data: json["Data"] == null ? [] : List<RewardData>.from(json["Data"]!.map((x) => RewardData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
    "Error": error,
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class RewardData {
  String? fileId;
  String? fileName;
  int? filePrice;
  int? approvedReports;
  int? reportsSubmitted;
  int? votedReports;
  int? votedReportsApproved;
  double? balance;

  RewardData({
    this.fileId,
    this.fileName,
    this.filePrice,
    this.approvedReports,
    this.reportsSubmitted,
    this.votedReports,
    this.votedReportsApproved,
    this.balance,
  });

  factory RewardData.fromJson(Map<String, dynamic> json) => RewardData(
    fileId: json["fileId"],
    fileName: json["fileName"],
    filePrice: json["filePrice"],
    approvedReports: json["approvedReports"],
    reportsSubmitted: json["reportsSubmitted"],
    votedReports: json["votedReports"],
    votedReportsApproved: json["votedReportsApproved"],
    balance: json["balance"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "fileId": fileId,
    "fileName": fileName,
    "filePrice": filePrice,
    "approvedReports": approvedReports,
    "reportsSubmitted": reportsSubmitted,
    "votedReports": votedReports,
    "votedReportsApproved": votedReportsApproved,
    "balance": balance,
  };
}
