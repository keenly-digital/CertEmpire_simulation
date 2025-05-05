import 'package:certempiree/core/utils/permission_handler.dart';
import 'package:dio/dio.dart';
import '../../utils/log_util.dart';
import 'api_endpoint.dart';
import 'api_result.dart';
import 'dio_client_config.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class ApiManager {
  final ApiClient _client;

  ApiManager(this._client);

  Future<ApiResult<T>> get<T>(
    ApiEndpoint endpoint, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _client.dio.get(
        endpoint.path,
        queryParameters: queryParameters,
      );
      return ApiResult.success(response.data);
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  Future<ApiResult<T>> post<T>(
    ApiEndpoint endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _client.dio.post(
        endpoint.path,
        data: data,
        queryParameters: queryParameters,
      );
      return ApiResult.success(response.data);
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  Future<ApiResult<T>> delete<T>(
    ApiEndpoint endpoint, {
    dynamic data,
    String? pathParam,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      String path;
      if (pathParam != null) {
        path = endpoint.path + pathParam;
      } else {
        path = endpoint.path;
      }

      final response = await _client.dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return ApiResult.success(response.data);
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  Future<ApiResult<T>> put<T>(
    ApiEndpoint endpoint, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await _client.dio.put(
        endpoint.path,
        data: data,
        queryParameters: queryParameters,
      );
      return ApiResult.success(response.data);
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  Future<ApiResult<T>> uploadFile<T>(
    ApiEndpoint endpoint, {
    required File file,
    String fileKey = 'file',
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    required Function(double progress) onProgress,
  }) async {
    try {
      final fileName = file.path.split('/').last;
      final formData = FormData.fromMap({
        fileKey: await MultipartFile.fromFile(file.path, filename: fileName),
        if (data != null) ...data,
      });

      final response = await _client.dio.post(endpoint.path, data: formData,
          onSendProgress: (sent, total) {
        if (total != 0) {
          onProgress(sent / total);
        }
      }, queryParameters: queryParameters);
      return ApiResult.success(response.data);
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  Future<ApiResult<T>> downloadFile<T>(
    String url, {
    required String fileName, // Custom filename without extension
    Map<String, dynamic>? queryParameters,
    required Function(double progress) onProgress,
  }) async {
    try {
      // Get the Downloads directory or a suitable alternative
      String saveDir;

      if (Platform.isAndroid) {
        bool isDirectoryExist=false;
        // Public Downloads folder
        // Android: Use external storage Downloads folder
        if (await PermissionHandler().requestStoragePermission()) {
          saveDir = "/storage/emulated/0/Download";
          isDirectoryExist = await Directory(saveDir).exists();
          if(isDirectoryExist){
            saveDir = "/storage/emulated/0/Download";
          }else{
            saveDir = "/storage/emulated/0/Downloads";
          }

        } else {
          saveDir = (await getApplicationDocumentsDirectory()).path; // Fallback
        }
      } else if (Platform.isIOS) {
        // iOS: Use Documents directory (Downloads isn't directly accessible)
        saveDir = (await getApplicationDocumentsDirectory()).path;
        // Note: True Downloads folder requires file picker or iCloud
      } else if (Platform.isMacOS) {
        // macOS: Use Downloads with proper entitlements or fallback to Documents
        saveDir = (await getDownloadsDirectory())?.path ??
            (await getApplicationDocumentsDirectory()).path;
      } else if (Platform.isWindows || Platform.isLinux) {
        // Windows/Linux: Downloads folder is typically accessible
        saveDir = (await getDownloadsDirectory())!.path;
      } else {
        // Fallback for unsupported platforms (e.g., web)
        saveDir = (await getTemporaryDirectory()).path;
      }

      // Construct the full save path with .qzs extension
      final savePath = '$saveDir/$fileName.qzs';

      // Ensure the directory exists (not strictly necessary, but good practice)
      final directory = Directory(saveDir);
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }

      // Perform the download
      final response = await _client.dio.download(
        url,
        savePath,
        queryParameters: queryParameters,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            onProgress(received / total);
          }
        },
      );

      if (response.statusCode == 200) {
        final file = File(savePath);
        if (await file.exists()) {
          LogUtil.debug('File saved to: $savePath');
          // Return the file as T (caller must specify T as File or handle casting)
          // return ApiResult.success(file as T);
          return ApiResult.success(
              APIResponse.getJson("File saved to: Downloads") as T);
        } else {
          return ApiResult.failure(
              'File not found after download at: $savePath');
        }
      } else {
        return ApiResult.failure(
            'Download failed with status: ${response.statusCode}');
      }
    } catch (e) {
      LogUtil.debug('Error downloading file: $e');
      return _handleError<T>(e); // Updated to generic T
    }
  }

  Future<ApiResult<T>> addQuestion<T>(
    ApiEndpoint endpoint, {
    Map<String, dynamic>? questionData,
    File? imageFile,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      // Create FormData object
      FormData formData = FormData.fromMap({
        // Add question fields with empty values if not provided
        'id': questionData?['id'] ?? -1,
        'fileId': questionData?['fileId'] ?? '',
        'questionText': questionData?['questionText'] ?? '',
        'questionDescription': questionData?['questionDescription'] ?? '',
        'options': questionData?['options'] ?? [],
        'correctAnswerIndices': questionData?['correctAnswerIndices'] ?? [],
        'answerDescription': questionData?['answerDescription'] ?? '',
        'explanation': questionData?['explanation'] ?? '',
        'isMultiSelect': questionData?['isMultiSelect'] ?? false,
        'userAnswerIndices': questionData?['userAnswerIndices'] ?? [],
        'isAttempted': questionData?['isAttempted'] ?? false,
        'showAnswer': questionData?['showAnswer'] ?? false,
        'imageURL': questionData?['imageURL'],
        'timeTaken': questionData?['timeTaken'],
        'topicId': questionData?['topicId'],
        'caseStudyId': questionData?['caseStudyId'],

        // Add image file if provided
        if (imageFile != null)
          'file': await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          ),
      });

      LogUtil.debug('FORM-DATA- ${formData.fields}');

      final response = await _client.dio.post(
        endpoint.path,
        data: formData,
        queryParameters: queryParameters,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      return ApiResult.success(response.data);
    } catch (e) {
      return _handleError<T>(e);
    }
  }

  ApiResult<T> _handleError<T>(dynamic error) {
    if (error is DioException) {
      return ApiResult.failure(_mapErrorToMessage(error));
    }
    return ApiResult.failure('An unexpected error occurred');
  }

  String _mapErrorToMessage(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timed out, please try again';
      case DioExceptionType.sendTimeout:
        return 'Send timed out, please try again';
      case DioExceptionType.receiveTimeout:
        return 'Receive timed out, please try again';
      case DioExceptionType.badResponse:
        switch (exception.response?.statusCode) {
          case 400:
            return 'Invalid request';
          case 401:
            return 'Unauthorized, please log in';
          case 404:
            return 'Resource not found';
          case 500:
            return 'Internal server error';
          default:
            return 'Received invalid status code: ${exception.response?.statusCode}';
        }
      case DioExceptionType.cancel:
        return 'Request was cancelled';
      case DioExceptionType.unknown:
        return 'No internet connection detected';
      default:
        return 'An unknown error occurred';
    }
  }
}
