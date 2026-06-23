// DATA LAYER
// Reads a single topic object (title + summary + videos) out of the JSON.
import 'package:awn/core/API/end_point.dart';
import 'package:awn/core/API/domain/entities/topic.dart';
import 'package:awn/core/API/data/models/video_model.dart';

class TopicModel extends Topic {
  TopicModel({
    required super.title,
    required super.summary,
    required super.videos,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      title: json[ApiKey.title]?.toString() ?? '',
      summary: json[ApiKey.summary]?.toString() ??
          json['content']?.toString() ??
          json['description']?.toString() ??
          '',
      videos: VideoModel.listFrom(json[ApiKey.videos]),
    );
  }

  static List<TopicModel> listFrom(dynamic raw) {
    if (raw is! List) return [];
    return raw
        .whereType<Map>()
        .map((e) => TopicModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
