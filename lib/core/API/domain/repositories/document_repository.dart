// DOMAIN LAYER
// This is a "contract" (abstract class). It only says WHAT we can do with
// documents, not HOW. The screens depend on this simple promise.
// The real "HOW" lives in the data layer (document_repository_impl.dart).
import 'package:awn/core/API/domain/entities/document_result.dart';
import 'package:awn/core/API/domain/entities/document.dart';
import 'package:awn/core/API/domain/entities/document_page.dart';
import 'package:awn/core/API/domain/entities/document_status.dart';
import 'package:awn/core/API/domain/entities/video.dart';

abstract class DocumentRepository {
  // Send one file (image or PDF) from the phone to the server to be summarized.
  Future<DocumentResult> uploadDocument({required String filePath});

  // Get a paginated list of the user's documents (optionally filtered by status).
  Future<DocumentPage> listDocuments({int page, int limit, String? status});

  // Lightweight poll of one document's processing status.
  Future<DocumentStatus> getStatus(String id);

  // Get a full document including its topics, summaries and videos.
  Future<Document> getDocument(String id);

  // Re-fetch the suggested videos for one topic (by index).
  Future<List<Video>> refreshTopicVideos(String id, int topicIndex);

  // Permanently delete a document.
  Future<void> deleteDocument(String id);
}
