import 'package:json_annotation/json_annotation.dart';

part 'chapter.g.dart';

@JsonSerializable()
class Chapter {
  final String id;
  final String? image;
  final String title;
  final String? description;
  final String url;
  final int? minutes;
  final DateTime createdAt;

  Chapter({
    required this.id,
    this.image,
    required this.title,
    this.description,
    required this.url,
    this.minutes,
    required this.createdAt,
  });

  Chapter copyWith(
          {String? newImage,
          String? newTitle,
          String? newDescription,
          String? newUrl,
          int? newMinutes}) =>
      Chapter(
        id: id,
        image: newImage ?? image,
        title: newTitle ?? title,
        description: newDescription ?? description,
        url: newUrl ?? url,
        minutes: newMinutes ?? minutes,
        createdAt: createdAt,
      );

  /// Connect the generated [_$ChapterFromJson] function to the `fromJson`
  /// factory.
  factory Chapter.fromJson(Map<String, dynamic> json) =>
      _$ChapterFromJson(json);

  /// Connect the generated [_$ChapterToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ChapterToJson(this);
}

List<Chapter> chaptersList = [
  Chapter(
    id: "id",
    image: "assets/images/les_eco.jpg",
    title: "Economics - 2",
    description:
        "The Last Lesson is set in the days of the Franco-Prussian War (1870-1871) in which France was defeated by Prussia led by Bismarck. Prussia then consisted of what now are the nations  of Germany, Poland and parts of Austria. In this story the French districts of Alsace and Lorraine have passed into Prussian hands.",
    url: "https://www.youtube.com/watch?v=eiGdsH1g20k",
    minutes: 54,
    createdAt: DateTime.now(),
  ),
  Chapter(
    id: "id",
    image: "assets/images/les_eco.jpg",
    title: "Economics - 2",
    description:
        "The Last Lesson is set in the days of the Franco-Prussian War (1870-1871) in which France was defeated by Prussia led by Bismarck. Prussia then consisted of what now are the nations  of Germany, Poland and parts of Austria. In this story the French districts of Alsace and Lorraine have passed into Prussian hands.",
    url: "https://www.youtube.com/watch?v=eiGdsH1g20k",
    minutes: 54,
    createdAt: DateTime.now(),
  ),
  Chapter(
    id: "id",
    image: "assets/images/les_eco.jpg",
    title: "Economics - 2",
    description:
        "The Last Lesson is set in the days of the Franco-Prussian War (1870-1871) in which France was defeated by Prussia led by Bismarck. Prussia then consisted of what now are the nations  of Germany, Poland and parts of Austria. In this story the French districts of Alsace and Lorraine have passed into Prussian hands.",
    minutes: 54,
    url: "https://www.youtube.com/watch?v=eiGdsH1g20k",
    createdAt: DateTime.now(),
  ),
  Chapter(
    id: "id",
    image: "assets/images/les_eco.jpg",
    title: "Economics - 2",
    description:
        "The Last Lesson is set in the days of the Franco-Prussian War (1870-1871) in which France was defeated by Prussia led by Bismarck. Prussia then consisted of what now are the nations  of Germany, Poland and parts of Austria. In this story the French districts of Alsace and Lorraine have passed into Prussian hands.",
    minutes: 54,
    url: "https://www.youtube.com/watch?v=eiGdsH1g20k",
    createdAt: DateTime.now(),
  ),
  Chapter(
    id: "id",
    image: "assets/images/les_eco.jpg",
    title: "Economics - 2",
    description:
        "The Last Lesson is set in the days of the Franco-Prussian War (1870-1871) in which France was defeated by Prussia led by Bismarck. Prussia then consisted of what now are the nations  of Germany, Poland and parts of Austria. In this story the French districts of Alsace and Lorraine have passed into Prussian hands.",
    minutes: 54,
    url: "https://www.youtube.com/watch?v=eiGdsH1g20k",
    createdAt: DateTime.now(),
  ),
];
