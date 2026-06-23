// DOMAIN LAYER
// A single YouTube video suggestion attached to a topic.
class Video {
  final String title;
  final String url; // full watch URL
  final String videoId; // the YouTube id (if the server sends it)
  final String thumbnail; // thumbnail image URL
  final String channel; // channel name (optional)

  Video({
    required this.title,
    required this.url,
    required this.videoId,
    required this.thumbnail,
    required this.channel,
  });
}
