// DATA LAYER
// The "remote data source" is the part that actually talks to the internet.
// It uses our ApiConsumer (Dio) to send requests to the document endpoints.
import 'package:dio/dio.dart';

import 'package:awn/core/API/api_consumer.dart';
import 'package:awn/core/API/end_point.dart';
import 'package:awn/core/API/data/models/document_result_model.dart';
import 'package:awn/core/API/data/models/document_model.dart';
import 'package:awn/core/API/data/models/document_page_model.dart';
import 'package:awn/core/API/data/models/document_status_model.dart';
import 'package:awn/core/API/data/models/video_model.dart';

abstract class DocumentRemoteDataSource {
  Future<DocumentResultModel> uploadDocument({required String filePath});

  Future<DocumentPageModel> listDocuments({
    int page,
    int limit,
    String? status,
  });

  Future<DocumentStatusModel> getStatus(String id);

  Future<DocumentModel> getDocument(String id);

  Future<List<VideoModel>> refreshTopicVideos(String id, int topicIndex);

  Future<void> deleteDocument(String id);
}

class DocumentRemoteDataSourceImpl implements DocumentRemoteDataSource {
  final ApiConsumer api;

  DocumentRemoteDataSourceImpl({required this.api});

  // POST https://.../api/documents/upload   body: the file (multipart)
  @override
  Future<DocumentResultModel> uploadDocument({required String filePath}) async {
    // A file upload is not plain JSON. We wrap the file in a FormData object,
    // which Dio sends as "multipart/form-data" (the format the server wants).
    final formData = FormData.fromMap({
      ApiKey.file: await MultipartFile.fromFile(filePath),
    });

    final response = await api.post(EndPoint.uploadDocument, data: formData);
    return DocumentResultModel.fromJson(response);
  }

  // GET https://.../api/documents?page=&limit=&status=
  @override
  Future<DocumentPageModel> listDocuments({
    int page = 1,
    int limit = 10,
    String? status,
  }) async {
    final query = <String, dynamic>{
      ApiKey.page: page,
      ApiKey.limit: limit,
      if (status != null && status.isNotEmpty) ApiKey.status: status,
    };

    final response = await api.get(EndPoint.documents, querParameters: query);
    return DocumentPageModel.fromJson(response);
  }

  // GET https://.../api/documents/:id/status
  @override
  Future<DocumentStatusModel> getStatus(String id) async {
    final response = await api.get(EndPoint.documentStatus(id));
    return DocumentStatusModel.fromJson(response);
  }

  // GET https://.../api/documents/:id  -> full document with topics.
  @override
  Future<DocumentModel> getDocument(String id) async {
    final response = await api.get(EndPoint.document(id));
    final data = (response is Map ? response[ApiKey.data] : null) ?? {};
    final doc = data[ApiKey.document] ?? {};
    return DocumentModel.fromJson(Map<String, dynamic>.from(doc));
  }

  // GET https://.../api/documents/:id/topics/:index/videos/refresh
  @override
  Future<List<VideoModel>> refreshTopicVideos(String id, int topicIndex) async {
    final response = await api.get(EndPoint.refreshTopicVideos(id, topicIndex));
    final data = (response is Map ? response[ApiKey.data] : null) ?? {};
    return VideoModel.listFrom(data[ApiKey.videos]);
  }

  // DELETE https://.../api/documents/:id
  @override
  Future<void> deleteDocument(String id) async {
    await api.delete(EndPoint.document(id));
  }
}
