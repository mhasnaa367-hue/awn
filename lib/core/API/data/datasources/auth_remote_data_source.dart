// DATA LAYER
// The "remote data source" is the part that actually talks to the internet.
// It uses our ApiConsumer (Dio) to send POST requests to the server.
import 'package:awn/core/API/api_consumer.dart';
import 'package:awn/core/API/end_point.dart';
import 'package:awn/core/API/data/models/auth_result_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResultModel> login({
    required String email,
    required String password,
  });

  Future<AuthResultModel> register({
    required String name,
    required String email,
    required String password,
  });

  Future<void> forgotPassword({required String email}) async {}
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer api;

  AuthRemoteDataSourceImpl({required this.api});

  // POST https://.../api/auth/login   body: { email, password }
  @override
  Future<AuthResultModel> login({
    required String email,
    required String password,
  }) async {
    final response = await api.post(
      EndPoint.login,
      data: {ApiKey.email: email, ApiKey.password: password},
    );
    return AuthResultModel.fromJson(response);
  }

  // POST https://.../api/auth/register   body: { name, email, password }
  @override
  Future<AuthResultModel> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await api.post(
      EndPoint.register,
      data: {ApiKey.name: name, ApiKey.email: email, ApiKey.password: password},
    );
    return AuthResultModel.fromJson(response);
  }

  @override
  @override
  Future<void> forgotPassword({required String email}) async {
    await api.post(EndPoint.forgotPassword, data: {ApiKey.email: email});
  }
}
