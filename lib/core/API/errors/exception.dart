import 'package:awn/core/API/errors/error_model.dart';
import 'package:dio/dio.dart';

// Our own simple error type. It carries a readable message.
class ServerException implements Exception {
  final ErrorModel errModel;

  ServerException({required this.errModel});
}

// Turns any Dio error into a ServerException with a friendly message.
// If the server sent a JSON body with a "message", we use it.
// Otherwise (no internet, timeout, etc.) we use a generic message.
void handleDioExceotion(DioException e) {
  final data = e.response?.data;

  if (data is Map<String, dynamic>) {
    throw ServerException(errModel: ErrorModel.fromjson(data));
  }

  throw ServerException(
    errModel: ErrorModel(
      errorMessage: 'Network error, please check your connection and try again',
    ),
  );
}
