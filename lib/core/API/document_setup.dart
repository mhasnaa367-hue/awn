// HELPER
// This builds everything you need and gives you a ready DocumentRepository.
// In a screen you just write:
//
//   final docs = createDocumentRepository();
//   await docs.uploadDocument(filePath: ...);
//
import 'package:dio/dio.dart';

import 'package:awn/core/API/dio_consumer.dart';
import 'package:awn/core/API/data/datasources/document_remote_data_source.dart';
import 'package:awn/core/API/data/repositories/document_repository_impl.dart';
import 'package:awn/core/API/domain/repositories/document_repository.dart';

DocumentRepository createDocumentRepository() {
  final api = DioConsumer(dio: Dio()); // talks to the server
  final remote = DocumentRemoteDataSourceImpl(api: api); // upload call
  return DocumentRepositoryImpl(remoteDataSource: remote); // the clean repository
}
