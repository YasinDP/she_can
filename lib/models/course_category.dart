import 'package:json_annotation/json_annotation.dart';

part 'course_category.g.dart';

@JsonSerializable()
class CourseCategory {
  final String? id;
  final String name;

  CourseCategory({this.id, required this.name});

  /// Connect the generated [_$CourseCategoryFromJson] function to the `fromJson`
  /// factory.
  factory CourseCategory.fromJson(Map<String, dynamic> json) =>
      _$CourseCategoryFromJson(json);

  /// Connect the generated [_$CourseCategoryToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CourseCategoryToJson(this);
}

List<CourseCategory> categoryList = [
  CourseCategory(
    id: "1",
    name: "Design",
  ),
  CourseCategory(
    id: "2",
    name: "Development",
  ),
  CourseCategory(
    id: "3",
    name: "IT & Software",
  ),
  CourseCategory(
    id: "4",
    name: "Business",
  ),
  CourseCategory(
    id: "5",
    name: "Marketing",
  ),
  CourseCategory(
    id: "6",
    name: "Music",
  ),
  CourseCategory(
    id: "7",
    name: "Lifestyle",
  ),
];
