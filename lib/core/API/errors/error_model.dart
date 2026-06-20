// Holds the error message the server sends back.
// The server returns errors like: { "success": false, "message": "..." }
import '../end_point.dart';

class ErrorModel {
  final String errorMessage;

  ErrorModel({required this.errorMessage});

  factory ErrorModel.fromjson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      errorMessage:
          jsonData[ApiKey.message]?.toString() ?? 'Something went wrong',
    );
  }
}
