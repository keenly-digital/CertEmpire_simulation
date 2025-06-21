class OrderModel {
  String message;
  bool success;
  String error;
  List<OrderData> data;

  OrderModel({
    required this.message,
    required this.success,
    required this.error,
    required this.data,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      message: json['Message'] as String,
      success: json['Success'] as bool,
      error: json['Error'] as String,
      data:
          (json['Data'] as List)
              .map((item) => OrderData.fromJson(item as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'success': success,
      'error': error,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class OrderData {
  String order;
  String date;
  String status;
  String total;
  String actions;

  OrderData({
    required this.order,
    required this.date,
    required this.status,
    required this.total,
    required this.actions,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      order: json['order'] as String,
      date: json['date'] as String,
      status: json['status'] as String,
      total: json['total'] as String,
      actions: json['actions'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'order': order,
      'date': date,
      'status': status,
      'total': total,
      'actions': actions,
    };
  }
}
