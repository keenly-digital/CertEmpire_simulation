import 'package:certempiree/core/config/api/api_result.dart';

import '../../domain/repos/order_repo.dart';
import '../data_sources/order_remote_data_src.dart';
import '../models/order_data_model.dart';

class OrderRepoImp extends OrderRepo {
  final OrderDataSrc _orderDataSrc;

  OrderRepoImp(this._orderDataSrc);

  @override
  Future<ApiResult<APIResponse<OrderModel?>>> getUserReward(
    String userId,
    int pageSize,
    int pageNumber,
  ) async {
    return await _orderDataSrc.getUserReward(userId, pageSize, pageNumber);
  }
}
