// DATA LAYER
// Reads a full document object out of the server JSON. Works for both the
// list view (no topics) and the single view (with topics + summary).
import 'package:awn/core/API/end_point.dart';
import 'package:awn/core/API/domain/entities/document.dart';
import 'package:awn/core/API/data/models/topic_model.dart';

class DocumentModel extends Document {
  DocumentModel({
    required super.id,
    required super.originalName,
    required super.fileType,
    required super.fileSize,
    required super.status,
    required super.errorMessage,
    required super.summary,
    required super.topics,
    required super.createdAt,
    required super.updatedAt,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json[ApiKey.id]?.toString() ?? '',
      originalName: json[ApiKey.originalName]?.toString() ?? '',
      fileType: json[ApiKey.fileType]?.toString() ?? '',
      fileSize: (json[ApiKey.fileSize] as num?)?.toInt() ?? 0,
      status: json[ApiKey.status]?.toString() ?? '',
      errorMessage: json[ApiKey.errorMessage]?.toString(),
      summary: json[ApiKey.summary]?.toString() ?? '',
      topics: TopicModel.listFrom(json[ApiKey.topics]),
      createdAt: json[ApiKey.createdAt]?.toString() ?? '',
      updatedAt: json[ApiKey.updatedAt]?.toString() ?? '',
    );
  }
}
