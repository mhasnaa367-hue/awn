// DOMAIN LAYER
// "Entity" = a plain Dart class that describes WHAT a user is.
// It has NO json code and NO internet code. It is just data.
// The rest of the app (screens) will use this clean class.
class User {
  final String id;
  final String name;
  final String email;
  final String? avatar; // can be null
  final bool isVerified;
  final bool isActive;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.isVerified,
    required this.isActive,
  });
}
