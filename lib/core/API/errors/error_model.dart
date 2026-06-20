import 'package:awn/core/API/end_point.dart';

class ErrorModel {
  late final int status;
  late final String errorMessage;

  ErrorModel({required this.errorMessage, required this.status});

  factory ErrorModel.fromjson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      errorMessage: jsonData[ApiKey.ErrorMassage],
      status: jsonData[ApiKey.status],
    );
  }
}
