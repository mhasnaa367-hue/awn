// DATA LAYER
// Reads the FULL server response for an upload and turns it into a
// DocumentResult (id + status + file name + message).
//
// The server sends something like:
// {
//   "success": true,
//   "message": "File uploaded, processing started",
//   "data": { "document": { "_id": "...", "status": "pending",
//                           "originalName": "photo.pdf", ... } }
// }
import 'package:awn/core/API/end_point.dart';
import 'package:awn/core/API/domain/entities/document_result.dart';

class DocumentResultModel extends DocumentResult {
  DocumentResultModel({
    required super.id,
    required super.status,
    required super.originalName,
    required super.message,
  });

  factory DocumentResultModel.fromJson(Map<String, dynamic> json) {
    // The document is inside data -> document.
    final data = json[ApiKey.data] ?? {};
    final document = data[ApiKey.document] ?? {};

    return DocumentResultModel(
      id: document[ApiKey.id]?.toString() ?? '',
      status: document[ApiKey.status]?.toString() ?? '',
      originalName: document[ApiKey.originalName]?.toString() ?? '',
      message: json[ApiKey.message]?.toString() ?? 'Uploaded',
    );
  }
}
