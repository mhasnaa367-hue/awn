// HELPER
// This builds everything you need and gives you a ready AuthRepository.
// In a screen you just write:
//
//   final auth = createAuthRepository();
//   await auth.login(email: ..., password: ...);
//
import 'package:dio/dio.dart';

import 'package:awn/core/API/dio_consumer.dart';
import 'package:awn/core/API/data/datasources/auth_remote_data_source.dart';
import 'package:awn/core/API/data/repositories/auth_repository_impl.dart';
import 'package:awn/core/API/domain/repositories/auth_repository.dart';

AuthRepository createAuthRepository() {
  final api = DioConsumer(dio: Dio()); // talks to the server
  final remote = AuthRemoteDataSourceImpl(api: api); // login/register calls
  return AuthRepositoryImpl(remoteDataSource: remote); // the clean repository
}
