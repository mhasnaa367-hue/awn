// DOMAIN LAYER
// One topic the AI found inside a document: a title, a short summary,
// and a few suggested videos to watch.
import 'package:awn/core/API/domain/entities/video.dart';

class Topic {
  final String title;
  final String summary;
  final List<Video> videos;

  Topic({
    required this.title,
    required this.summary,
    required this.videos,
  });
}
