// DATA LAYER
// The "remote data source" is the part that actually talks to the internet.
// It uses our ApiConsumer (Dio) to send requests to the auth endpoints.
import 'package:awn/core/API/api_consumer.dart';
import 'package:awn/core/API/end_point.dart';
import 'package:awn/core/API/data/models/auth_result_model.dart';
import 'package:awn/core/API/data/models/user_model.dart';

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

  // POST /api/auth/forgot-password -> send a reset / verification code.
  Future<void> forgotPassword({required String email});

  // GET /api/auth/me  -> the current user.
  Future<UserModel> getMe();

  // PATCH /api/auth/me -> update name and/or avatar.
  Future<UserModel> updateProfile({String? name, String? avatar});

  // PATCH /api/auth/change-password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  // POST /api/auth/refresh -> a fresh token pair.
  Future<AuthResultModel> refresh({required String refreshToken});

  // POST /api/auth/logout -> revoke one refresh token.
  Future<void> logout({required String refreshToken});

  // POST /api/auth/logout-all -> revoke every refresh token.
  Future<void> logoutAll();

  // POST /api/auth/send-otp -> returns the minutes until the code expires.
  Future<int> sendOtp();

  // POST /api/auth/verify-email -> verifies the email, returns the user.
  Future<UserModel> verifyEmail({required String code});

  // POST /api/auth/resend-otp
  Future<void> resendOtp();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiConsumer api;

  AuthRemoteDataSourceImpl({required this.api});

  // Pulls the "data.user" object out of a response and builds a UserModel.
  UserModel _userFrom(dynamic response) {
    final data = (response is Map ? response[ApiKey.data] : null) ?? {};
    final user = data[ApiKey.user] ?? {};
    return UserModel.fromJson(Map<String, dynamic>.from(user));
  }

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

  // GET https://.../api/auth/me
  @override
  Future<UserModel> getMe() async {
    final response = await api.get(EndPoint.me);
    return _userFrom(response);
  }

  // PATCH https://.../api/auth/me   body: { name?, avatar? }
  @override
  Future<UserModel> updateProfile({String? name, String? avatar}) async {
    final body = <String, dynamic>{};
    if (name != null) body[ApiKey.name] = name;
    if (avatar != null) body[ApiKey.avatar] = avatar;

    final response = await api.patch(EndPoint.me, data: body);
    return _userFrom(response);
  }

  // PATCH https://.../api/auth/change-password
  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await api.patch(
      EndPoint.changePassword,
      data: {
        ApiKey.currentPassword: currentPassword,
        ApiKey.newPassword: newPassword,
      },
    );
  }

  // POST https://.../api/auth/refresh   body: { refreshToken }
  @override
  Future<AuthResultModel> refresh({required String refreshToken}) async {
    final response = await api.post(
      EndPoint.refresh,
      data: {ApiKey.refreshToken: refreshToken},
    );
    return AuthResultModel.fromJson(response);
  }

  // POST https://.../api/auth/logout   body: { refreshToken }
  @override
  Future<void> logout({required String refreshToken}) async {
    await api.post(
      EndPoint.logout,
      data: {ApiKey.refreshToken: refreshToken},
    );
  }

  // POST https://.../api/auth/logout-all
  @override
  Future<void> logoutAll() async {
    await api.post(EndPoint.logoutAll);
  }

  // POST https://.../api/auth/send-otp
  @override
  Future<int> sendOtp() async {
    final response = await api.post(EndPoint.sendOtp);
    final data = (response is Map ? response[ApiKey.data] : null) ?? {};
    return (data[ApiKey.expiresInMinutes] as num?)?.toInt() ?? 10;
  }

  // POST https://.../api/auth/verify-email   body: { code }
  @override
  Future<UserModel> verifyEmail({required String code}) async {
    final response = await api.post(
      EndPoint.verifyEmail,
      data: {ApiKey.code: code},
    );
    return _userFrom(response);
  }

  // POST https://.../api/auth/resend-otp
  @override
  Future<void> resendOtp() async {
    await api.post(EndPoint.resendOtp);
  }

  // POST https://.../api/auth/forgot-password   body: { email }
  @override
  Future<void> forgotPassword({required String email}) async {
    await api.post(EndPoint.forgotPassword, data: {ApiKey.email: email});
  }
}
