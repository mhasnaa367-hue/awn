// HELPER
// Builds a ready HealthRepository. Usage:
//
//   final health = createHealthRepository();
//   final ok = await health.checkHealth();
//
import 'package:dio/dio.dart';

import 'package:awn/core/API/dio_consumer.dart';
import 'package:awn/core/API/data/datasources/health_remote_data_source.dart';
import 'package:awn/core/API/data/repositories/health_repository_impl.dart';
import 'package:awn/core/API/domain/repositories/health_repository.dart';

HealthRepository createHealthRepository() {
  final api = DioConsumer(dio: Dio());
  final remote = HealthRemoteDataSourceImpl(api: api);
  return HealthRepositoryImpl(remoteDataSource: remote);
}
