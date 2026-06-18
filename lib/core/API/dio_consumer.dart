import 'dart:io';

import 'package:awn/core/API/api_consumer.dart';
import 'package:awn/core/API/errors/error_model.dart';
import 'package:awn/core/API/errors/exception.dart';
import 'package:dio/dio.dart';

class DioConsumer extends ApiConsumer {
  late final Dio dio;

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
  Future<dynamic> patch(
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
  Future<dynamic> post(
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
}
