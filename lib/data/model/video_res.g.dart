// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoRes _$VideoResFromJson(Map<String, dynamic> json) {
  return VideoRes(
    success: json['success'] as bool,
    response: json['response'] == null
        ? null
        : Res.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$VideoResToJson(VideoRes instance) => <String, dynamic>{
      'success': instance.success,
      'response': instance.response,
    };

Res _$ResFromJson(Map<String, dynamic> json) {
  return Res(
    hasMore: json['has_more'] as bool,
    totalVideos: json['total_videos'] as int,
    currentOffset: json['current_offset'] as int,
    limit: json['limit'] as int,
    videos: (json['videos'] as List)
        ?.map(
            (e) => e == null ? null : Video.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResToJson(Res instance) => <String, dynamic>{
      'has_more': instance.hasMore,
      'total_videos': instance.totalVideos,
      'current_offset': instance.currentOffset,
      'limit': instance.limit,
      'videos': instance.videos,
    };

Video _$VideoFromJson(Map<String, dynamic> json) {
  return Video(
    title: json['title'] as String,
    keyword: json['keyword'] as String,
    duration: (json['duration'] as num)?.toDouble(),
    framerate: (json['framerate'] as num)?.toDouble(),
    hd: json['hd'] as bool,
    addtime: json['addtime'] as int,
    viewnumber: json['viewnumber'] as int,
    likes: json['likes'] as int,
    dislikes: json['dislikes'] as int,
    videoUrl: json['video_url'] as String,
    embeddedUrl: json['embedded_url'] as String,
    previewUrl: json['preview_url'] as String,
    previewVideoUrl: json['preview_video_url'] as String,
    private: json['private'] as bool,
    vid: json['vid'] as String,
    uid: json['uid'] as String,
    atWatched: json['at_watched'] as String,
  );
}

Map<String, dynamic> _$VideoToJson(Video instance) => <String, dynamic>{
      'title': instance.title,
      'keyword': instance.keyword,
      'duration': instance.duration,
      'framerate': instance.framerate,
      'hd': instance.hd,
      'addtime': instance.addtime,
      'viewnumber': instance.viewnumber,
      'likes': instance.likes,
      'dislikes': instance.dislikes,
      'video_url': instance.videoUrl,
      'embedded_url': instance.embeddedUrl,
      'preview_url': instance.previewUrl,
      'preview_video_url': instance.previewVideoUrl,
      'private': instance.private,
      'vid': instance.vid,
      'uid': instance.uid,
      'at_watched': instance.atWatched,
    };
