// DOMAIN LAYER
// This is what we get back after uploading a file for summarizing:
// the document the server created (its id, status and the file name) plus
// the friendly message the server sent us.
class DocumentResult {
  final String id; // the document's id on the server
  final String status; // pending / processing / done / failed
  final String originalName; // the name of the file the user picked
  final String message; // e.g. "File uploaded, processing started"

  DocumentResult({
    required this.id,
    required this.status,
    required this.originalName,
    required this.message,
  });
}
