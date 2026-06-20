// DATA LAYER
// Reads the FULL server response for login/register and turns it into
// an AuthResult (user + tokens).
//
// The server sends something like:
// {
//   "success": true,
//   "message": "Login successful",
//   "data": { "user": {...}, "accessToken": "...", "refreshToken": "..." }
// }
import 'package:awn/core/API/domain/entities/auth_result.dart';
import 'package:awn/core/API/data/models/user_model.dart';

class AuthResultModel extends AuthResult {
  AuthResultModel({
    required super.user,
    required super.accessToken,
    required super.refreshToken,
  });

  factory AuthResultModel.fromJson(Map<String, dynamic> json) {
    // The user + tokens are inside the "data" object.
    final data = json['data'] ?? {};

    return AuthResultModel(
      user: UserModel.fromJson(data['user'] ?? {}),
      accessToken: data['accessToken'] ?? '',
      refreshToken: data['refreshToken'] ?? '',
    );
  }
}
