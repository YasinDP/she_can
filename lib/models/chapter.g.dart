// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chapter _$ChapterFromJson(Map<String, dynamic> json) => Chapter(
      id: json['id'] as String,
      image: json['image'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      url: json['url'] as String,
      minutes: json['minutes'] as int?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ChapterToJson(Chapter instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'minutes': instance.minutes,
      'createdAt': instance.createdAt.toIso8601String(),
    };
