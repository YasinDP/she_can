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

List<Course> allCourseList = [
  Course(
    id: "1",
    thumbnail:
        "https://prod-discovery.edx-cdn.org/media/course/image/52bf4539-6137-4968-9605-6c32414dcdc4-7e805a266b31.small.png",
    name: "Become a Super Learner - Learn speed reading Boost Memory",
    instructor: "Rupesh Gondaliya",
    description:
        "Lorem ipsum volutpat non in dolor quisque quis, blandit ultrices vitae erat in tortor, quis eu est. Leo feugiat sodales dignissim nulla ipsum dolor sit amet, eu rutrum Leo feugiat sodales dignissim nulla sodales dignissim.",
    category: CourseCategory(
      id: "1",
      name: "Design",
    ),
    chapters: chaptersList,
  ),
  Course(
    id: "1",
    thumbnail:
        "https://prod-discovery.edx-cdn.org/media/course/image/52bf4539-6137-4968-9605-6c32414dcdc4-7e805a266b31.small.png",
    name: "Become a Super Learner - Learn speed reading Boost Memory",
    instructor: "Rupesh Gondaliya",
    description:
        "Lorem ipsum volutpat non in dolor quisque quis, blandit ultrices vitae erat in tortor, quis eu est. Leo feugiat sodales dignissim nulla ipsum dolor sit amet, eu rutrum Leo feugiat sodales dignissim nulla sodales dignissim.",
    category: CourseCategory(
      id: "1",
      name: "Design",
    ),
    chapters: chaptersList,
  ),
  Course(
    id: "1",
    thumbnail:
        "https://prod-discovery.edx-cdn.org/media/course/image/52bf4539-6137-4968-9605-6c32414dcdc4-7e805a266b31.small.png",
    name: "Become a Super Learner - Learn speed reading Boost Memory",
    instructor: "Rupesh Gondaliya",
    description:
        "Lorem ipsum volutpat non in dolor quisque quis, blandit ultrices vitae erat in tortor, quis eu est. Leo feugiat sodales dignissim nulla ipsum dolor sit amet, eu rutrum Leo feugiat sodales dignissim nulla sodales dignissim.",
    category: CourseCategory(
      id: "1",
      name: "Design",
    ),
    chapters: chaptersList,
  ),
  Course(
    id: "1",
    thumbnail:
        "https://prod-discovery.edx-cdn.org/media/course/image/52bf4539-6137-4968-9605-6c32414dcdc4-7e805a266b31.small.png",
    name: "Become a Super Learner - Learn speed reading Boost Memory",
    instructor: "Rupesh Gondaliya",
    description:
        "Lorem ipsum volutpat non in dolor quisque quis, blandit ultrices vitae erat in tortor, quis eu est. Leo feugiat sodales dignissim nulla ipsum dolor sit amet, eu rutrum Leo feugiat sodales dignissim nulla sodales dignissim.",
    category: CourseCategory(
      id: "1",
      name: "Design",
    ),
    chapters: chaptersList,
  ),
  Course(
    id: "1",
    thumbnail:
        "https://prod-discovery.edx-cdn.org/media/course/image/52bf4539-6137-4968-9605-6c32414dcdc4-7e805a266b31.small.png",
    name: "Become a Super Learner - Learn speed reading Boost Memory",
    instructor: "Rupesh Gondaliya",
    description:
        "Lorem ipsum volutpat non in dolor quisque quis, blandit ultrices vitae erat in tortor, quis eu est. Leo feugiat sodales dignissim nulla ipsum dolor sit amet, eu rutrum Leo feugiat sodales dignissim nulla sodales dignissim.",
    category: CourseCategory(
      id: "1",
      name: "Design",
    ),
    chapters: chaptersList,
  ),
];

List<Course> myCourseList = [
  Course(
    id: "1",
    thumbnail:
        "https://prod-discovery.edx-cdn.org/media/course/image/52bf4539-6137-4968-9605-6c32414dcdc4-7e805a266b31.small.png",
    name: "Become a Super Learner - Learn speed reading Boost Memory",
    instructor: "Rupesh Gondaliya",
    description:
        "Lorem ipsum volutpat non in dolor quisque quis, blandit ultrices vitae erat in tortor, quis eu est. Leo feugiat sodales dignissim nulla ipsum dolor sit amet, eu rutrum Leo feugiat sodales dignissim nulla sodales dignissim.",
    category: CourseCategory(id: "id", name: "Academic"),
    chapters: [],
  ),
  Course(
    id: "1",
    thumbnail:
        "https://prod-discovery.edx-cdn.org/media/course/image/52bf4539-6137-4968-9605-6c32414dcdc4-7e805a266b31.small.png",
    name: "Become a Super Learner - Learn speed reading Boost Memory",
    instructor: "Rupesh Gondaliya",
    description:
        "Lorem ipsum volutpat non in dolor quisque quis, blandit ultrices vitae erat in tortor, quis eu est. Leo feugiat sodales dignissim nulla ipsum dolor sit amet, eu rutrum Leo feugiat sodales dignissim nulla sodales dignissim.",
    category: CourseCategory(
      id: "1",
      name: "Design",
    ),
    chapters: chaptersList,
  ),
];

List<Course> savedCourseList = [
  Course(
    id: "1",
    thumbnail:
        "https://prod-discovery.edx-cdn.org/media/course/image/52bf4539-6137-4968-9605-6c32414dcdc4-7e805a266b31.small.png",
    name: "Become a Super Learner - Learn speed reading Boost Memory",
    instructor: "Rupesh Gondaliya",
    description:
        "Lorem ipsum volutpat non in dolor quisque quis, blandit ultrices vitae erat in tortor, quis eu est. Leo feugiat sodales dignissim nulla ipsum dolor sit amet, eu rutrum Leo feugiat sodales dignissim nulla sodales dignissim.",
    category: CourseCategory(id: "id", name: "Academic"),
    chapters: [],
  ),
  Course(
    id: "1",
    thumbnail:
        "https://prod-discovery.edx-cdn.org/media/course/image/52bf4539-6137-4968-9605-6c32414dcdc4-7e805a266b31.small.png",
    name: "Become a Super Learner - Learn speed reading Boost Memory",
    instructor: "Rupesh Gondaliya",
    description:
        "Lorem ipsum volutpat non in dolor quisque quis, blandit ultrices vitae erat in tortor, quis eu est. Leo feugiat sodales dignissim nulla ipsum dolor sit amet, eu rutrum Leo feugiat sodales dignissim nulla sodales dignissim.",
    category: CourseCategory(
      id: "1",
      name: "Design",
    ),
    chapters: chaptersList,
  ),
  Course(
    id: "1",
    thumbnail:
        "https://prod-discovery.edx-cdn.org/media/course/image/52bf4539-6137-4968-9605-6c32414dcdc4-7e805a266b31.small.png",
    name: "Become a Super Learner - Learn speed reading Boost Memory",
    instructor: "Rupesh Gondaliya",
    description:
        "Lorem ipsum volutpat non in dolor quisque quis, blandit ultrices vitae erat in tortor, quis eu est. Leo feugiat sodales dignissim nulla ipsum dolor sit amet, eu rutrum Leo feugiat sodales dignissim nulla sodales dignissim.",
    category: CourseCategory(
      id: "1",
      name: "Design",
    ),
    chapters: chaptersList,
  ),
  Course(
    id: "1",
    thumbnail:
        "https://prod-discovery.edx-cdn.org/media/course/image/52bf4539-6137-4968-9605-6c32414dcdc4-7e805a266b31.small.png",
    name: "Become a Super Learner - Learn speed reading Boost Memory",
    instructor: "Rupesh Gondaliya",
    description:
        "Lorem ipsum volutpat non in dolor quisque quis, blandit ultrices vitae erat in tortor, quis eu est. Leo feugiat sodales dignissim nulla ipsum dolor sit amet, eu rutrum Leo feugiat sodales dignissim nulla sodales dignissim.",
    category: CourseCategory(
      id: "1",
      name: "Design",
    ),
    chapters: chaptersList,
  ),
];
