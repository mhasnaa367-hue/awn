// DOMAIN LAYER
// This is a "contract" (abstract class). It only says WHAT auth can do,
// not HOW. The screens depend on this simple promise.
// The real "HOW" lives in the data layer (auth_repository_impl.dart).
import 'package:awn/core/API/domain/entities/auth_result.dart';
import 'package:awn/core/API/domain/entities/user.dart';

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

  // Ask the server to send a password-reset / verification code to this email.
  Future<void> forgotPassword({
    required String email,
  });

  // Get the currently logged-in user.
  Future<User> getMe();

  // Update the current user's name and/or avatar.
  Future<User> updateProfile({String? name, String? avatar});

  // Change the password (server revokes all refresh tokens afterwards).
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  // Exchange the saved refresh token for a fresh token pair.
  Future<AuthResult> refresh();

  // Log out of this device (revokes the saved refresh token).
  Future<void> logout();

  // Log out of every device.
  Future<void> logoutAll();

  // Email verification (OTP). Returns minutes until the code expires.
  Future<int> sendOtp();

  // Submit the OTP code; returns the (now verified) user.
  Future<User> verifyEmail({required String code});

  // Ask the server to send a new OTP code.
  Future<void> resendOtp();
}
