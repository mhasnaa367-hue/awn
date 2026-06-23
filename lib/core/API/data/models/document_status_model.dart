// DATA LAYER
// Reads the lightweight status poll response: data.status + data.errorMessage.
import 'package:awn/core/API/end_point.dart';
import 'package:awn/core/API/domain/entities/document_status.dart';

class DocumentStatusModel extends DocumentStatus {
  DocumentStatusModel({
    required super.status,
    required super.errorMessage,
  });

  factory DocumentStatusModel.fromJson(Map<String, dynamic> json) {
    final data = json[ApiKey.data] ?? {};
    return DocumentStatusModel(
      status: data[ApiKey.status]?.toString() ?? '',
      errorMessage: data[ApiKey.errorMessage]?.toString(),
    );
  }
}
