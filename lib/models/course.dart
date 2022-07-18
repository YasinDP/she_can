import 'package:json_annotation/json_annotation.dart';
import 'package:she_can/models/chapter.dart';
import 'package:she_can/models/course_category.dart';

part 'course.g.dart';

@JsonSerializable(explicitToJson: true)
class Course {
  final String id;
  final String name;
  final String? description;
  final String? thumbnail;
  final CourseCategory category;
  final List<Chapter> chapters;
  final String instructor;

  Course({
    required this.id,
    required this.name,
    this.description,
    this.thumbnail,
    required this.category,
    required this.chapters,
    required this.instructor,
  });

  /// Connect the generated [_$CourseFromJson] function to the `fromJson`
  /// factory.
  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  /// Connect the generated [_$CourseToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
