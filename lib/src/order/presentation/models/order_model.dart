class OrderDataModel {
  bool? success;
  String? message;
  String? error;
  List<OrdersDetails>? data;

  OrderDataModel({
    this.success,
    this.message,
    this.error,
    this.data,
  });

  factory OrderDataModel.fromJson(Map<String, dynamic> json) => OrderDataModel(
    success: json["Success"],
    message: json["Message"],
    error: json["Error"],
    data: json["Data"] == null ? [] : List<OrdersDetails>.from(json["Data"]!.map((x) => OrdersDetails.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
    "Error": error,
    "Data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class OrdersDetails {
  int? id;
  String? status;
  String? currency;
  String? total;
  String? paymentMethod;
  String? paymentTitle;
  String? createdVia;
  String? dateCreated;
  Ing? billing;
  Ing? shipping;
  List<LineItem>? lineItems;
  List<dynamic>? shippingMethods;
  List<dynamic>? coupons;
  List<dynamic>? refunds;
  String? customerNote;
  List<MetaDatum>? metaData;

  OrdersDetails({
    this.id,
    this.status,
    this.currency,
    this.total,
    this.paymentMethod,
    this.paymentTitle,
    this.createdVia,
    this.dateCreated,
    this.billing,
    this.shipping,
    this.lineItems,
    this.shippingMethods,
    this.coupons,
    this.refunds,
    this.customerNote,
    this.metaData,
  });

  factory OrdersDetails.fromJson(Map<String, dynamic> json) => OrdersDetails(
    id: json["id"],
    status: json["status"],
    currency: json["currency"],
    total: json["total"],
    paymentMethod: json["payment_method"],
    paymentTitle: json["payment_title"],
    createdVia: json["created_via"],
    dateCreated: json["date_created"],
    billing: json["billing"] == null ? null : Ing.fromJson(json["billing"]),
    shipping: json["shipping"] == null ? null : Ing.fromJson(json["shipping"]),
    lineItems: json["line_items"] == null ? [] : List<LineItem>.from(json["line_items"]!.map((x) => LineItem.fromJson(x))),
    shippingMethods: json["shipping_methods"] == null ? [] : List<dynamic>.from(json["shipping_methods"]!.map((x) => x)),
    coupons: json["coupons"] == null ? [] : List<dynamic>.from(json["coupons"]!.map((x) => x)),
    refunds: json["refunds"] == null ? [] : List<dynamic>.from(json["refunds"]!.map((x) => x)),
    customerNote: json["customer_note"],
    metaData: json["meta_data"] == null ? [] : List<MetaDatum>.from(json["meta_data"]!.map((x) => MetaDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "currency": currency,
    "total": total,
    "payment_method": paymentMethod,
    "payment_title": paymentTitle,
    "created_via": createdVia,
    "date_created": dateCreated,
    "billing": billing?.toJson(),
    "shipping": shipping?.toJson(),
    "line_items": lineItems == null ? [] : List<dynamic>.from(lineItems!.map((x) => x.toJson())),
    "shipping_methods": shippingMethods == null ? [] : List<dynamic>.from(shippingMethods!.map((x) => x)),
    "coupons": coupons == null ? [] : List<dynamic>.from(coupons!.map((x) => x)),
    "refunds": refunds == null ? [] : List<dynamic>.from(refunds!.map((x) => x)),
    "customer_note": customerNote,
    "meta_data": metaData == null ? [] : List<dynamic>.from(metaData!.map((x) => x.toJson())),
  };
}

class Ing {
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? email;
  String? phone;

  Ing({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.email,
    this.phone,
  });

  factory Ing.fromJson(Map<String, dynamic> json) => Ing(
    firstName: json["first_name"],
    lastName: json["last_name"],
    company: json["company"],
    address1: json["address_1"],
    address2: json["address_2"],
    city: json["city"],
    state: json["state"],
    postcode: json["postcode"],
    country: json["country"],
    email: json["email"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "company": company,
    "address_1": address1,
    "address_2": address2,
    "city": city,
    "state": state,
    "postcode": postcode,
    "country": country,
    "email": email,
    "phone": phone,
  };
}

class LineItem {
  int? productId;
  int? variationId;
  String? name;
  int? quantity;
  String? subtotal;
  String? total;
  String? taxClass;
  List<dynamic>? metaData;
  String? sku;
  String? price;

  LineItem({
    this.productId,
    this.variationId,
    this.name,
    this.quantity,
    this.subtotal,
    this.total,
    this.taxClass,
    this.metaData,
    this.sku,
    this.price,
  });

  factory LineItem.fromJson(Map<String, dynamic> json) => LineItem(
    productId: json["product_id"],
    variationId: json["variation_id"],
    name: json["name"],
    quantity: json["quantity"],
    subtotal: json["subtotal"],
    total: json["total"],
    taxClass: json["tax_class"],
    metaData: json["meta_data"] == null ? [] : List<dynamic>.from(json["meta_data"]!.map((x) => x)),
    sku: json["sku"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "variation_id": variationId,
    "name": name,
    "quantity": quantity,
    "subtotal": subtotal,
    "total": total,
    "tax_class": taxClass,
    "meta_data": metaData == null ? [] : List<dynamic>.from(metaData!.map((x) => x)),
    "sku": sku,
    "price": price,
  };
}

class MetaDatum {
  int? id;
  String? key;
  dynamic value;

  MetaDatum({
    this.id,
    this.key,
    this.value,
  });

  factory MetaDatum.fromJson(Map<String, dynamic> json) => MetaDatum(
    id: json["id"],
    key: json["key"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "key": key,
    "value": value,
  };
}

class ValueClass {
  List<dynamic>? billing;
  List<dynamic>? order;
  List<dynamic>? account;

  ValueClass({
    this.billing,
    this.order,
    this.account,
  });

  factory ValueClass.fromJson(Map<String, dynamic> json) => ValueClass(
    billing: json["billing"] == null ? [] : List<dynamic>.from(json["billing"]!.map((x) => x)),
    order: json["order"] == null ? [] : List<dynamic>.from(json["order"]!.map((x) => x)),
    account: json["account"] == null ? [] : List<dynamic>.from(json["account"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "billing": billing == null ? [] : List<dynamic>.from(billing!.map((x) => x)),
    "order": order == null ? [] : List<dynamic>.from(order!.map((x) => x)),
    "account": account == null ? [] : List<dynamic>.from(account!.map((x) => x)),
  };
}
