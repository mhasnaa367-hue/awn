// DOMAIN LAYER
// A document the user uploaded. In the list view most of these fields are
// filled but `topics` is empty. In the full (single) view `topics` and
// `summary` are populated once the status is "done".
import 'package:awn/core/API/domain/entities/topic.dart';

class Document {
  final String id;
  final String originalName;
  final String fileType; // pdf / docx / image ...
  final int fileSize; // bytes
  final String status; // pending / processing / done / failed
  final String? errorMessage; // set when status == failed
  final String summary; // overall summary (may be empty)
  final List<Topic> topics; // empty in list view
  final String createdAt;
  final String updatedAt;

  Document({
    required this.id,
    required this.originalName,
    required this.fileType,
    required this.fileSize,
    required this.status,
    required this.errorMessage,
    required this.summary,
    required this.topics,
    required this.createdAt,
    required this.updatedAt,
  });

  bool get isDone => status == 'done';
  bool get isFailed => status == 'failed';
  bool get isProcessing => status == 'pending' || status == 'processing';
}
