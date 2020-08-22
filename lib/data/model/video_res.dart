import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'video_res.g.dart';

@immutable
@JsonSerializable()
class VideoRes {
  const VideoRes({
    this.success,
    this.response,
  });

  factory VideoRes.fromJson(Map<String, dynamic> json) =>
      _$VideoResFromJson(json);

  final bool success;
  final Res response;
}

@immutable
@JsonSerializable()
class Res {
  const Res({
    this.hasMore,
    this.totalVideos,
    this.currentOffset,
    this.limit,
    this.videos,
  });

  factory Res.fromJson(Map<String, dynamic> json) => _$ResFromJson(json);

  @JsonKey(name: 'has_more')
  final bool hasMore;
  @JsonKey(name: 'total_videos')
  final int totalVideos;
  @JsonKey(name: 'current_offset')
  final int currentOffset;
  final int limit;
  final List<Video> videos;
}

@immutable
@JsonSerializable()
class Video {
  const Video({
    this.title,
    this.keyword,
    this.duration,
    this.framerate,
    this.hd,
    this.addtime,
    this.viewnumber,
    this.likes,
    this.dislikes,
    this.videoUrl,
    this.embeddedUrl,
    this.previewUrl,
    this.previewVideoUrl,
    this.private,
    this.vid,
    this.uid,
  });

  factory Video.fromJson(Map<String, dynamic> json) => _$VideoFromJson(json);

  final String title;
  final String keyword;
  final double duration;
  final double framerate;
  final bool hd;
  final int addtime;
  final int viewnumber;
  final int likes;
  final int dislikes;
  @JsonKey(name: 'video_url')
  final String videoUrl;
  @JsonKey(name: 'embedded_url')
  final String embeddedUrl;
  @JsonKey(name: 'preview_url')
  final String previewUrl;
  @JsonKey(name: 'preview_video_url')
  final String previewVideoUrl;
  final bool private;
  final String vid;
  final String uid;
}