// DOMAIN LAYER
// This is what we get back after a successful login or register:
// the logged-in user + the two tokens the server gives us.
import 'package:awn/core/API/domain/entities/user.dart';

class AuthResult {
  final User user;
  final String accessToken; // short-lived token, used for normal requests
  final String refreshToken; // long-lived token, used to get a new accessToken

  AuthResult({
    required this.user,
    required this.accessToken,
    required this.refreshToken,
  });
}
