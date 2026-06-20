// DATA LAYER
// This is the REAL implementation of the AuthRepository contract.
// It simply asks the remote data source to do the network work.
// (In a bigger app this is also where you'd save the tokens, etc.)
import 'package:awn/core/API/domain/entities/auth_result.dart';
import 'package:awn/core/API/domain/repositories/auth_repository.dart';
import 'package:awn/core/API/data/datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AuthResult> login({
    required String email,
    required String password,
  }) {
    return remoteDataSource.login(email: email, password: password);
  }

  @override
  Future<AuthResult> register({
    required String name,
    required String email,
    required String password,
  }) {
    return remoteDataSource.register(
      name: name,
      email: email,
      password: password,
    );
  }
}
