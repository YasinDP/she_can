import 'package:json_annotation/json_annotation.dart';

part 'news.g.dart';

@JsonSerializable()
class News {
  final String id;
  final String image;
  final String title;
  final String content;
  final String instructor;
  final DateTime publishedAt;

  News({
    required this.id,
    required this.image,
    required this.title,
    required this.content,
    required this.instructor,
    required this.publishedAt,
  });

  /// Connect the generated [_$NewsFromJson] function to the `fromJson`
  /// factory.
  factory News.fromJson(Map<String, dynamic> json) => _$NewsFromJson(json);

  /// Connect the generated [_$NewsToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$NewsToJson(this);
}
