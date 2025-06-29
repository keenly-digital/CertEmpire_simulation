class UserData {
  bool? success;
  String? message;
  String? error;
  UserInfoData? data;

  UserData({this.success, this.message, this.error, this.data});

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    success: json["Success"],
    message: json["Message"],
    error: json["Error"],
    data: json["Data"] == null ? null : UserInfoData.fromJson(json["Data"]),
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Message": message,
    "Error": error,
    "Data": data?.toJson(),
  };

  UserData copyWith({
    bool? success,
    String? message,
    String? error,
    UserInfoData? data,
  }) {
    return UserData(
      success: success ?? this.success,
      message: message ?? this.message,
      error: error ?? this.error,
      data: data ?? this.data,
    );
  }
}

class UserInfoData {
  int? id;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  String? email;
  String? firstName;
  String? lastName;
  String? role;
  String? username;
  String? currentPassword;
  String? newPassword;
  Ing? billing;
  Ing? shipping;
  bool? isPayingCustomer;
  String? avatarUrl;
  List<SelectedCurrency>? currencyOptions;
  SelectedCurrency? selectedCurrency;

  UserInfoData({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.email,
    this.firstName,
    this.lastName,
    this.role,
    this.username,
    this.currentPassword,
    this.newPassword,
    this.billing,
    this.shipping,
    this.isPayingCustomer,
    this.avatarUrl,
    this.currencyOptions,
    this.selectedCurrency,
  });

  factory UserInfoData.fromJson(Map<String, dynamic> json) => UserInfoData(
    id: json["id"],
    dateCreated:
        json["date_created"] == null
            ? null
            : DateTime.parse(json["date_created"]),
    dateCreatedGmt:
        json["date_created_gmt"] == null
            ? null
            : DateTime.parse(json["date_created_gmt"]),
    dateModified:
        json["date_modified"] == null
            ? null
            : DateTime.parse(json["date_modified"]),
    dateModifiedGmt:
        json["date_modified_gmt"] == null
            ? null
            : DateTime.parse(json["date_modified_gmt"]),
    email: json["email"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    role: json["role"],
    username: json["username"],
    billing: json["billing"] == null ? null : Ing.fromJson(json["billing"]),
    shipping: json["shipping"] == null ? null : Ing.fromJson(json["shipping"]),
    isPayingCustomer: json["is_paying_customer"],
    avatarUrl: json["avatar_url"],
    currencyOptions:
        json["currency_options"] == null
            ? []
            : List<SelectedCurrency>.from(
              json["currency_options"]!.map(
                (x) => SelectedCurrency.fromJson(x),
              ),
            ),
    selectedCurrency:
        json["selected_currency"] == null
            ? null
            : SelectedCurrency.fromJson(json["selected_currency"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date_created": dateCreated?.toIso8601String(),
    "date_created_gmt": dateCreatedGmt?.toIso8601String(),
    "date_modified": dateModified?.toIso8601String(),
    "date_modified_gmt": dateModifiedGmt?.toIso8601String(),
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "role": role,
    "username": username,
    "billing": billing?.toJson(),
    "shipping": shipping?.toJson(),
    "is_paying_customer": isPayingCustomer,
    "avatar_url": avatarUrl,
    "currency_options":
        currencyOptions == null
            ? []
            : List<dynamic>.from(currencyOptions!.map((x) => x.toJson())),
    "selected_currency": selectedCurrency?.toJson(),
  };

  UserInfoData copyWith({
    int? id,
    DateTime? dateCreated,
    DateTime? dateCreatedGmt,
    DateTime? dateModified,
    DateTime? dateModifiedGmt,
    String? email,
    String? firstName,
    String? lastName,
    String? role,
    String? username,
    String? currentPassword,
    String? newPassword,
    Ing? billing,
    Ing? shipping,
    bool? isPayingCustomer,
    String? avatarUrl,
    List<SelectedCurrency>? currencyOptions,
    SelectedCurrency? selectedCurrency,
  }) {
    return UserInfoData(
      id: id ?? this.id,
      dateCreated: dateCreated ?? this.dateCreated,
      dateCreatedGmt: dateCreatedGmt ?? this.dateCreatedGmt,
      dateModified: dateModified ?? this.dateModified,
      dateModifiedGmt: dateModifiedGmt ?? this.dateModifiedGmt,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      role: role ?? this.role,
      username: username ?? this.username,
      currentPassword: currentPassword ?? this.currentPassword,
      newPassword: newPassword ?? this.newPassword,
      billing: billing ?? this.billing,
      shipping: shipping ?? this.shipping,
      isPayingCustomer: isPayingCustomer ?? this.isPayingCustomer,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      currencyOptions: currencyOptions ?? this.currencyOptions,
      selectedCurrency: selectedCurrency ?? this.selectedCurrency,
    );
  }
}

class Ing {
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? postcode;
  String? country;
  String? state;
  String? email;
  String? phone;

  Ing({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.postcode,
    this.country,
    this.state,
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
    postcode: json["postcode"],
    country: json["country"],
    state: json["state"],
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
    "postcode": postcode,
    "country": country,
    "state": state,
    "email": email,
    "phone": phone,
  };

  Ing copyWith({
    String? firstName,
    String? lastName,
    String? company,
    String? address1,
    String? address2,
    String? city,
    String? postcode,
    String? country,
    String? state,
    String? email,
    String? phone,
  }) {
    return Ing(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      company: company ?? this.company,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      city: city ?? this.city,
      postcode: postcode ?? this.postcode,
      country: country ?? this.country,
      state: state ?? this.state,
      email: email ?? this.email,
      phone: phone ?? this.phone,
    );
  }
}

class SelectedCurrency {
  String? code;
  String? symbol;
  String? name;

  SelectedCurrency({this.code, this.symbol, this.name});

  factory SelectedCurrency.fromJson(Map<String, dynamic> json) =>
      SelectedCurrency(
        code: json["code"],
        symbol: json["symbol"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
    "code": code,
    "symbol": symbol,
    "name": name,
  };

  SelectedCurrency copyWith({String? code, String? symbol, String? name}) {
    return SelectedCurrency(
      code: code ?? this.code,
      symbol: symbol ?? this.symbol,
      name: name ?? this.name,
    );
  }
}
