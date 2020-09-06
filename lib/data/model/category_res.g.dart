// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_res.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryRes _$CategoryResFromJson(Map<String, dynamic> json) {
  return CategoryRes(
    success: json['success'] as bool,
    response: json['response'] == null
        ? null
        : Res.fromJson(json['response'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CategoryResToJson(CategoryRes instance) =>
    <String, dynamic>{
      'success': instance.success,
      'response': instance.response,
    };

Res _$ResFromJson(Map<String, dynamic> json) {
  return Res(
    categories: (json['categories'] as List)
        ?.map((e) =>
            e == null ? null : Category.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ResToJson(Res instance) => <String, dynamic>{
      'categories': instance.categories,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return Category(
    chid: json['CHID'] as String,
    name: json['name'] as String,
    slug: json['slug'] as String,
    totalVideos: json['total_videos'] as int,
    shortname: json['shortname'] as String,
    categoryUrl: json['category_url'] as String,
    coverUrl: json['cover_url'] as String,
  );
}

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'CHID': instance.chid,
      'name': instance.name,
      'slug': instance.slug,
      'total_videos': instance.totalVideos,
      'shortname': instance.shortname,
      'category_url': instance.categoryUrl,
      'cover_url': instance.coverUrl,
    };
