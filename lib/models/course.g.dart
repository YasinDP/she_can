// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      thumbnail: json['thumbnail'] as String,
      category:
          CourseCategory.fromJson(json['category'] as Map<String, dynamic>),
      chapters: (json['chapters'] as List<dynamic>)
          .map((e) => Chapter.fromJson(e as Map<String, dynamic>))
          .toList(),
      instructor: json['instructor'] as String,
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
      'category': instance.category.toJson(),
      'chapters': instance.chapters.map((e) => e.toJson()).toList(),
      'instructor': instance.instructor,
    };
