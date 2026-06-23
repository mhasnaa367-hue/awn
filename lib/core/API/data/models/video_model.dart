// DATA LAYER
// Reads a single video object out of the server JSON. The exact field names
// can vary, so we look under a few common keys and fall back to empty.
import 'package:awn/core/API/end_point.dart';
import 'package:awn/core/API/domain/entities/video.dart';

class VideoModel extends Video {
  VideoModel({
    required super.title,
    required super.url,
    required super.videoId,
    required super.thumbnail,
    required super.channel,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    final id = json[ApiKey.videoId]?.toString() ??
        json['id']?.toString() ??
        '';

    // Build a watch URL from the id if the server didn't send a full url.
    final url = json[ApiKey.url]?.toString() ??
        (id.isNotEmpty ? 'https://www.youtube.com/watch?v=$id' : '');

    return VideoModel(
      title: json[ApiKey.title]?.toString() ?? '',
      url: url,
      videoId: id,
      thumbnail: json[ApiKey.thumbnail]?.toString() ??
          json['thumbnailUrl']?.toString() ??
          '',
      channel: json[ApiKey.channel]?.toString() ??
          json['channelTitle']?.toString() ??
          '',
    );
  }

  // Parse a list of videos defensively (null -> empty list).
  static List<VideoModel> listFrom(dynamic raw) {
    if (raw is! List) return [];
    return raw
        .whereType<Map>()
        .map((e) => VideoModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}
