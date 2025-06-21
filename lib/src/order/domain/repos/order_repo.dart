import '../../../../core/config/api/api_result.dart';
import '../../data/models/order_data_model.dart';

abstract class OrderRepo {
  Future<ApiResult<APIResponse<OrderModel?>>> getUserReward(
    String userId,
    int pageSize,
    int pageNumber,
  );
}
