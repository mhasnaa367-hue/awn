// DATA LAYER
// This is the REAL implementation of the AuthRepository contract.
// It asks the remote data source to do the network work and keeps the
// saved tokens (TokenStorage) in sync.
import 'package:awn/core/API/domain/entities/auth_result.dart';
import 'package:awn/core/API/domain/entities/user.dart';
import 'package:awn/core/API/domain/repositories/auth_repository.dart';
import 'package:awn/core/API/data/datasources/auth_remote_data_source.dart';
import 'package:awn/core/API/errors/error_model.dart';
import 'package:awn/core/API/errors/exception.dart';
import 'package:awn/core/API/token_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    final result = await remoteDataSource.login(email: email, password: password);
    // Save both tokens so the interceptor can attach the access token and
    // /refresh & /logout can use the refresh token.
    await TokenStorage.save(result.accessToken, result.refreshToken);
    return result;
  }

  @override
  Future<AuthResult> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final result = await remoteDataSource.register(
      name: name,
      email: email,
      password: password,
    );
    await TokenStorage.save(result.accessToken, result.refreshToken);
    return result;
  }

  @override
  Future<void> forgotPassword({
    required String email,
  }) async {
    await remoteDataSource.forgotPassword(email: email);
  }

  @override
  Future<User> getMe() => remoteDataSource.getMe();

  @override
  Future<User> updateProfile({String? name, String? avatar}) =>
      remoteDataSource.updateProfile(name: name, avatar: avatar);

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await remoteDataSource.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
    // The server revokes all refresh tokens after a password change, so the
    // saved tokens are no longer valid — clear them and force a fresh login.
    await TokenStorage.clear();
  }

  @override
  Future<AuthResult> refresh() async {
    final token = TokenStorage.refreshToken;
    if (token == null || token.isEmpty) {
      throw ServerException(
        errModel: ErrorModel(errorMessage: 'No refresh token available'),
      );
    }
    final result = await remoteDataSource.refresh(refreshToken: token);
    await TokenStorage.save(result.accessToken, result.refreshToken);
    return result;
  }

  @override
  Future<void> logout() async {
    final token = TokenStorage.refreshToken;
    try {
      if (token != null && token.isNotEmpty) {
        await remoteDataSource.logout(refreshToken: token);
      }
    } finally {
      // Whatever the server says, drop the local session.
      await TokenStorage.clear();
    }
  }

  @override
  Future<void> logoutAll() async {
    try {
      await remoteDataSource.logoutAll();
    } finally {
      await TokenStorage.clear();
    }
  }

  @override
  Future<int> sendOtp() => remoteDataSource.sendOtp();

  @override
  Future<User> verifyEmail({required String code}) =>
      remoteDataSource.verifyEmail(code: code);

  @override
  Future<void> resendOtp() => remoteDataSource.resendOtp();
}
