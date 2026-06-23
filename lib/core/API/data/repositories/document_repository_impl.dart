// DATA LAYER
// This is the REAL implementation of the DocumentRepository contract.
// It simply asks the remote data source to do the network work.
import 'package:awn/core/API/domain/entities/document_result.dart';
import 'package:awn/core/API/domain/entities/document.dart';
import 'package:awn/core/API/domain/entities/document_page.dart';
import 'package:awn/core/API/domain/entities/document_status.dart';
import 'package:awn/core/API/domain/entities/video.dart';
import 'package:awn/core/API/domain/repositories/document_repository.dart';
import 'package:awn/core/API/data/datasources/document_remote_data_source.dart';

class DocumentRepositoryImpl implements DocumentRepository {
  final DocumentRemoteDataSource remoteDataSource;

  DocumentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DocumentResult> uploadDocument({required String filePath}) =>
      remoteDataSource.uploadDocument(filePath: filePath);

  @override
  Future<DocumentPage> listDocuments({
    int page = 1,
    int limit = 10,
    String? status,
  }) =>
      remoteDataSource.listDocuments(page: page, limit: limit, status: status);

  @override
  Future<DocumentStatus> getStatus(String id) => remoteDataSource.getStatus(id);

  @override
  Future<Document> getDocument(String id) => remoteDataSource.getDocument(id);

  @override
  Future<List<Video>> refreshTopicVideos(String id, int topicIndex) =>
      remoteDataSource.refreshTopicVideos(id, topicIndex);

  @override
  Future<void> deleteDocument(String id) =>
      remoteDataSource.deleteDocument(id);
}
