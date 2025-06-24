// To parse this JSON data, do
//
//     final downloadModel = downloadModelFromJson(jsonString);

import 'dart:convert';

List<DownloadModel> downloadModelFromJson(String str) => List<DownloadModel>.from(json.decode(str).map((x) => DownloadModel.fromJson(x)));

String downloadModelToJson(List<DownloadModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DownloadModel {
  String? downloadId;
  String? downloadUrl;
  int? productId;
  String? productName;
  String? downloadName;
  int? orderId;
  String? orderKey;
  String? downloadsRemaining;
  String? accessExpires;
  String? accessExpiresGmt;
  FileClass? file;
  Links? links;
  String? downloadedUrl;
  String? fileId;

  DownloadModel({
    this.downloadId,
    this.downloadUrl,
    this.productId,
    this.productName,
    this.downloadName,
    this.orderId,
    this.orderKey,
    this.downloadsRemaining,
    this.accessExpires,
    this.accessExpiresGmt,
    this.file,
    this.links,
    this.downloadedUrl,
    this.fileId,
  });

  factory DownloadModel.fromJson(Map<String, dynamic> json) => DownloadModel(
    downloadId: json["download_id"],
    downloadUrl: json["download_url"],
    productId: json["product_id"],
    productName: json["product_name"],
    downloadName: json["download_name"],
    orderId: json["order_id"],
    orderKey: json["order_key"],
    downloadsRemaining: json["downloads_remaining"],
    accessExpires: json["access_expires"],
    accessExpiresGmt: json["access_expires_gmt"],
    file: json["file"] == null ? null : FileClass.fromJson(json["file"]),
    links: json["_links"] == null ? null : Links.fromJson(json["_links"]),
  );

  Map<String, dynamic> toJson() => {
    "download_id": downloadId,
    "download_url": downloadUrl,
    "product_id": productId,
    "product_name": productName,
    "download_name": downloadName,
    "order_id": orderId,
    "order_key": orderKey,
    "downloads_remaining": downloadsRemaining,
    "access_expires": accessExpires,
    "access_expires_gmt": accessExpiresGmt,
    "file": file?.toJson(),
    "_links": links?.toJson(),
  };
}

class FileClass {
  String? name;
  String? file;

  FileClass({
    this.name,
    this.file,
  });

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
    name: json["name"],
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "file": file,
  };
}

class Links {
  List<Collection>? collection;
  List<Collection>? product;
  List<Collection>? order;

  Links({
    this.collection,
    this.product,
    this.order,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    collection: json["collection"] == null ? [] : List<Collection>.from(json["collection"]!.map((x) => Collection.fromJson(x))),
    product: json["product"] == null ? [] : List<Collection>.from(json["product"]!.map((x) => Collection.fromJson(x))),
    order: json["order"] == null ? [] : List<Collection>.from(json["order"]!.map((x) => Collection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "collection": collection == null ? [] : List<dynamic>.from(collection!.map((x) => x.toJson())),
    "product": product == null ? [] : List<dynamic>.from(product!.map((x) => x.toJson())),
    "order": order == null ? [] : List<dynamic>.from(order!.map((x) => x.toJson())),
  };
}

class Collection {
  String? href;

  Collection({
    this.href,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}
