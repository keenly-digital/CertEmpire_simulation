
class UrlsModel {
  bool? success;
  String? message;
  String? error;
  List<Datum>? data;

  UrlsModel({
    this.success,
    this.message,
    this.error,
    this.data,
  });

  factory UrlsModel.fromJson(Map<String, dynamic> json) => UrlsModel(
    success: json["Success"],
    message: json["Message"],
    error: json["Error"],
    data: json["Data"] == null ? [] : List<Datum>.from(json["Data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
    "Error": error,
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  String? fileId;
  String? fileUrl;

  Datum({
    this.fileId,
    this.fileUrl,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    fileId: json["fileId"],
    fileUrl: json["fileUrl"],
  );

  Map<String, dynamic> toJson() => {
    "fileId": fileId,
    "fileUrl": fileUrl,
  };
}
