import 'package:awn/core/API/errors/error_model.dart';
import 'package:dio/dio.dart';

class ServerException implements Exception {
  late final ErrorModel errModel;

  ServerException({required this.errModel});
}

void handleDioExceotion(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(errModel: ErrorModel.fromjson(e.response!.data));
    case DioExceptionType.sendTimeout:
      throw ServerException(errModel: ErrorModel.fromjson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw ServerException(errModel: ErrorModel.fromjson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw ServerException(errModel: ErrorModel.fromjson(e.response!.data));
    case DioExceptionType.cancel:
      throw ServerException(errModel: ErrorModel.fromjson(e.response!.data));
    case DioExceptionType.connectionError:
      throw ServerException(errModel: ErrorModel.fromjson(e.response!.data));
    case DioExceptionType.unknown:
      throw ServerException(errModel: ErrorModel.fromjson(e.response!.data));
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400:
          throw ServerException(
            errModel: ErrorModel.fromjson(e.response!.data),
          );
        case 401:
          throw ServerException(
            errModel: ErrorModel.fromjson(e.response!.data),
          );
        case 403:
          throw ServerException(
            errModel: ErrorModel.fromjson(e.response!.data),
          );
        case 404:
          throw ServerException(
            errModel: ErrorModel.fromjson(e.response!.data),
          );
        case 409:
          throw ServerException(
            errModel: ErrorModel.fromjson(e.response!.data),
          );
        case 422:
          throw ServerException(
            errModel: ErrorModel.fromjson(e.response!.data),
          );
        case 504:
          throw ServerException(
            errModel: ErrorModel.fromjson(e.response!.data),
          );
      }
  }
}
