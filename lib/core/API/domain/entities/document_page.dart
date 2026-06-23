// DOMAIN LAYER
// One page of the user's documents plus the pagination info the server sends.
import 'package:awn/core/API/domain/entities/document.dart';

class Pagination {
  final int page;
  final int limit;
  final int total;
  final int totalPages;

  Pagination({
    required this.page,
    required this.limit,
    required this.total,
    required this.totalPages,
  });
}

class DocumentPage {
  final List<Document> documents;
  final Pagination pagination;

  DocumentPage({
    required this.documents,
    required this.pagination,
  });
}
