import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_res.g.dart';

@immutable
@JsonSerializable()
class CategoryRes {
  const CategoryRes({
    this.success,
    this.response,
  });

  factory CategoryRes.fromJson(Map<String, dynamic> json) =>
      _$CategoryResFromJson(json);

  final bool success;
  final Res response;
}

@immutable
@JsonSerializable()
class Res {
  const Res({
    this.categories,
  });

  factory Res.fromJson(Map<String, dynamic> json) => _$ResFromJson(json);

  final List<Category> categories;
}

@immutable
@JsonSerializable()
class Category {
  const Category({
    this.chid,
    this.name,
    this.slug,
    this.totalVideos,
    this.shortname,
    this.categoryUrl,
    this.coverUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  @JsonKey(name: 'CHID')
  final String chid;
  final String name;
  final String slug;
  @JsonKey(name: 'total_videos')
  final int totalVideos;
  final String shortname;
  @JsonKey(name: 'category_url')
  final String categoryUrl;
  @JsonKey(name: 'cover_url')
  final String coverUrl;
}
