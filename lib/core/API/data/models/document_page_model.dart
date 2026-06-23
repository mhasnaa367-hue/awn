// DATA LAYER
// Reads the paginated list response: data.documents[] + data.pagination.
import 'package:awn/core/API/end_point.dart';
import 'package:awn/core/API/domain/entities/document_page.dart';
import 'package:awn/core/API/data/models/document_model.dart';

class PaginationModel extends Pagination {
  PaginationModel({
    required super.page,
    required super.limit,
    required super.total,
    required super.totalPages,
  });

  factory PaginationModel.fromJson(Map<String, dynamic> json) {
    return PaginationModel(
      page: (json[ApiKey.page] as num?)?.toInt() ?? 1,
      limit: (json[ApiKey.limit] as num?)?.toInt() ?? 10,
      total: (json[ApiKey.total] as num?)?.toInt() ?? 0,
      totalPages: (json[ApiKey.totalPages] as num?)?.toInt() ?? 1,
    );
  }
}

class DocumentPageModel extends DocumentPage {
  DocumentPageModel({
    required super.documents,
    required super.pagination,
  });

  factory DocumentPageModel.fromJson(Map<String, dynamic> json) {
    final data = json[ApiKey.data] ?? {};
    final rawDocs = data[ApiKey.documents];
    final documents = (rawDocs is List)
        ? rawDocs
            .whereType<Map>()
            .map((e) => DocumentModel.fromJson(Map<String, dynamic>.from(e)))
            .toList()
        : <DocumentModel>[];

    final rawPagination = data[ApiKey.pagination];
    final pagination = PaginationModel.fromJson(
      rawPagination is Map
          ? Map<String, dynamic>.from(rawPagination)
          : <String, dynamic>{},
    );

    return DocumentPageModel(documents: documents, pagination: pagination);
  }
}
