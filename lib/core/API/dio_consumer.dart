import 'package:awn/core/API/api_consumer.dart';
import 'package:awn/core/API/api_interceptor.dart';
import 'package:awn/core/API/errors/exception.dart';
import 'package:dio/dio.dart';

class DioConsumer extends ApiConsumer {
  late final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = "https://awn-production-edb2.up.railway.app/";
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ),
    );
  }

  @override
  Future<dynamic> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? querParameters,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: data,
        queryParameters: querParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceotion(e);
    }
  }

  @override
  Future<dynamic> get(
    String path, {
    Object? data,
    Map<String, dynamic>? querParameters,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: querParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceotion(e);
    }
  }

  @override
  Future<dynamic> patch(
    String path, {
    Object? data,
    Map<String, dynamic>? querParameters,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: data,
        queryParameters: querParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceotion(e);
    }
  }

  @override
  Future<dynamic> post(
    String path, {
    Object? data,
    Map<String, dynamic>? querParameters,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: data,
        queryParameters: querParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceotion(e);
    }
  }
}
