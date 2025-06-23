

abstract class OrderInitEvent {}

class GetOrderEvent extends OrderInitEvent {
  String userId;
  int pageSize;
  int pageNumber;

  GetOrderEvent({
    required this.userId,
    required this.pageNumber,
    required this.pageSize,
  });
}
