// DOMAIN LAYER
// The lightweight result of polling a document's processing status.
class DocumentStatus {
  final String status; // pending / processing / done / failed
  final String? errorMessage; // set when status == failed

  DocumentStatus({
    required this.status,
    required this.errorMessage,
  });

  bool get isDone => status == 'done';
  bool get isFailed => status == 'failed';
  bool get isProcessing => status == 'pending' || status == 'processing';
}
