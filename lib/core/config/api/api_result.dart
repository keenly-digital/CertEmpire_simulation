// Sealed class for representing result states
abstract class ApiResult<T> {
  const ApiResult();

  /// Helper to create a success result
  factory ApiResult.success(T data) = Success<T>;

  /// Helper to create a failure result
  factory ApiResult.failure(String message) = Failure<T>;

  /// Apply a function depending on the result type
  R when<R>({
    required R Function(T data) onSuccess,
    required R Function(String message) onFailure,
  }) {
    if (this is Success<T>) {
      return onSuccess((this as Success<T>).data);
    } else if (this is Failure<T>) {
      return onFailure((this as Failure<T>).message);
    } else {
      throw Exception('Unknown result type');
    }
  }

  /// Check if this is a success
  bool get isSuccess => this is Success<T>;

  /// Check if this is a failure
  bool get isFailure => this is Failure<T>;
}

/// Success state
class Success<T> extends ApiResult<T> {
  final T data;

  const Success(this.data);
}

/// Failure state
class Failure<T> extends ApiResult<T> {
  final String message;

  const Failure(this.message);
}

class APIResponse<T> {
  final bool success;
  final String message;
  final String error;
  final T? data;

  APIResponse({
    required this.success,
    required this.message,
    required this.error,
    this.data,
  });

  // factory APIResponse.fromJson(
  //     Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
  //   return APIResponse(
  //     success: json['Success'] ?? false,
  //     message: json['Message'] ?? '',
  //     error: json['Error'] ?? '',
  //     data: json['Data'] != null ? fromJson(json['Data'] as Map<String, dynamic>) : null,
  //   );
  // }

  factory APIResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJson,
  ) {
    final rawData = json['Data'];
    T? parsedData;
    if (rawData == null || (rawData is String && rawData.isEmpty)) {
      parsedData = null; // Handle empty or null data
    } else if (rawData is String) {
      parsedData = fromJson(rawData);
    } else if (T is int || T is double || T == bool) {
      parsedData = rawData as T;
    } else if (rawData is List) {
      parsedData = fromJson(rawData);
    } else if (rawData is Map<String, dynamic>) {
      // Handle single object
      parsedData = fromJson(rawData);
    } else {
      throw Exception("Unexpected data format: $rawData");
    }

    return APIResponse(
      success: json['Success'] ?? false,
      message: json['Message'] ?? '',
      error: json['Error'] ?? '',
      data: parsedData,
    );
  }

  static Map<String, dynamic> getJson(String data) {
    return {'Success': true, 'Message': '', 'Error': '', 'Data': data};
  }
}
