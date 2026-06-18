import 'package:awn/core/API/errors/error_model.dart';
import 'package:dio/dio.dart';

class ServerExceotion implements Exception {
  late final ErrorModel errModel;

  ServerExceotion({required this.errModel});
}

void handleDioExceotion(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerExceotion(errModel: ErrorModel.fromjson(e.response!.data));
    case DioExceptionType.sendTimeout:
      throw ServerExceotion(errModel: ErrorModel.fromjson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw ServerExceotion(errModel: ErrorModel.fromjson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw ServerExceotion(errModel: ErrorModel.fromjson(e.response!.data));
    case DioExceptionType.cancel:
      throw ServerExceotion(errModel: ErrorModel.fromjson(e.response!.data));
    case DioExceptionType.connectionError:
      throw ServerExceotion(errModel: ErrorModel.fromjson(e.response!.data));
    case DioExceptionType.unknown:
      throw ServerExceotion(errModel: ErrorModel.fromjson(e.response!.data));
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400:
          throw ServerExceotion(
            errModel: ErrorModel.fromjson(e.response!.data),
          );
        case 401:
          throw ServerExceotion(
            errModel: ErrorModel.fromjson(e.response!.data),
          );
        case 403:
          throw ServerExceotion(
            errModel: ErrorModel.fromjson(e.response!.data),
          );
        case 404:
          throw ServerExceotion(
            errModel: ErrorModel.fromjson(e.response!.data),
          );
        case 409:
          throw ServerExceotion(
            errModel: ErrorModel.fromjson(e.response!.data),
          );
        case 422:
          throw ServerExceotion(
            errModel: ErrorModel.fromjson(e.response!.data),
          );
        case 504:
          throw ServerExceotion(
            errModel: ErrorModel.fromjson(e.response!.data),
          );
      }
  }
}
