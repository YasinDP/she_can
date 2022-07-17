// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$NewsFromJson(Map<String, dynamic> json) => News(
      id: json['id'] as String,
      image: json['image'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      instructor: json['instructor'] as String,
      publishedAt: DateTime.parse(json['publishedAt'] as String),
    );

Map<String, dynamic> _$NewsToJson(News instance) => <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'title': instance.title,
      'content': instance.content,
      'instructor': instance.instructor,
      'publishedAt': instance.publishedAt.toIso8601String(),
    };
