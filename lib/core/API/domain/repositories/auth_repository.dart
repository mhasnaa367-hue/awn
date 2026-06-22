// DOMAIN LAYER
// This is a "contract" (abstract class). It only says WHAT auth can do,
// not HOW. The screens depend on this simple promise.
// The real "HOW" lives in the data layer (auth_repository_impl.dart).
import 'package:awn/core/API/domain/entities/auth_result.dart';

abstract class AuthRepository {
  // Log in with email + password.
  Future<AuthResult> login({
    required String email,
    required String password,
  });

  // Create a new account with name + email + password.
  Future<AuthResult> register({
    required String name,
    required String email,
    required String password,
  });

  Future<void> forgotPassword({
    required String email,
  });
}
