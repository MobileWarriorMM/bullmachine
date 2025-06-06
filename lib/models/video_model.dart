class VideoModel {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String duration;
  final String uploadTime;
  final String views;
  final String author;
  final String videoUrl;
  final String description;
  final String subscriber;
  final bool isLive;
  final String? image; // New field for static asset path

  VideoModel({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.duration,
    required this.uploadTime,
    required this.views,
    required this.author,
    required this.videoUrl,
    required this.description,
    required this.subscriber,
    required this.isLive,
    this.image,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      id: json['id'] as String,
      title: json['title'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      duration: json['duration'] as String,
      uploadTime: json['uploadTime'] as String,
      views: json['views'] as String,
      author: json['author'] as String,
      videoUrl: json['videoUrl'] as String,
      description: json['description'] as String,
      subscriber: json['subscriber'] as String,
      isLive: json['isLive'] as bool,
      image: json['image'] as String?, // Handle image field
    );
  }
}