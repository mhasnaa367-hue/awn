// DATA LAYER
// A "Model" is like the Entity, but it ALSO knows how to read JSON
// that comes from the server. It "extends" User so it can be used
// anywhere a User is expected.
import 'package:awn/core/API/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    required super.avatar,
    required super.isVerified,
    required super.isActive,
  });

  // Build a UserModel from the JSON "user" object the server sends.
  // We use ?? to give a safe default if a field is missing.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'], // null is allowed here
      isVerified: json['isVerified'] ?? false,
      isActive: json['isActive'] ?? false,
    );
  }
}
