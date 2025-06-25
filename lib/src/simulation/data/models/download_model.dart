class DownloadModel {
  bool? success;
  String? message;
  String? error;
  List<DownloadedData>? data;

  DownloadModel({this.success, this.message, this.error, this.data});

  factory DownloadModel.fromJson(Map<String, dynamic> json) => DownloadModel(
    success: json["Success"],
    message: json["Message"],
    error: json["Error"],
    data:
        json["Data"] == null
            ? []
            : List<DownloadedData>.from(
              json["Data"]!.map((x) => DownloadedData.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
    "Error": error,
    "Data":
        data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DownloadedData {
  String? downloadId;
  int? productId;
  String? productName;
  String? downloadName;
  String? fileUrl;
  String? downloadsRemaining;
  String? accessExpires;
  int? orderId;
  String? orderDate;
  ProductMeta? productMeta;
  List<String>? tags;
  String? fileId;

  DownloadedData({
    this.downloadId,
    this.productId,
    this.productName,
    this.downloadName,
    this.fileUrl,
    this.downloadsRemaining,
    this.accessExpires,
    this.orderId,
    this.orderDate,
    this.productMeta,
    this.tags,
    this.fileId,
  });

  factory DownloadedData.fromJson(Map<String, dynamic> json) => DownloadedData(
    downloadId: json["download_id"],
    productId: json["product_id"],
    productName: json["product_name"],
    downloadName: json["download_name"],
    fileUrl: json["file_url"],
    downloadsRemaining: json["downloads_remaining"],
    accessExpires: json["access_expires"],
    orderId: json["order_id"],
    orderDate: json["order_date"],
    productMeta:
        json["product_meta"] == null
            ? null
            : ProductMeta.fromJson(json["product_meta"]),
    tags:
        json["tags"] == null
            ? []
            : List<String>.from(json["tags"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "download_id": downloadId,
    "product_id": productId,
    "product_name": productName,
    "download_name": downloadName,
    "file_url": fileUrl,
    "downloads_remaining": downloadsRemaining,
    "access_expires": accessExpires,
    "order_id": orderId,
    "order_date": orderDate,
    "product_meta": productMeta?.toJson(),
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
  };
}

class ProductMeta {
  String? sku;
  String? price;
  String? type;
  bool? virtual;
  bool? downloadable;

  ProductMeta({
    this.sku,
    this.price,
    this.type,
    this.virtual,
    this.downloadable,
  });

  factory ProductMeta.fromJson(Map<String, dynamic> json) => ProductMeta(
    sku: json["sku"],
    price: json["price"],
    type: json["type"],
    virtual: json["virtual"],
    downloadable: json["downloadable"],
  );

  Map<String, dynamic> toJson() => {
    "sku": sku,
    "price": price,
    "type": type,
    "virtual": virtual,
    "downloadable": downloadable,
  };
}
