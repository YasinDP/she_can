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

// List<News> allNewsList = [
//   News(
//     id: "id",
//     image:
//         "https://cdn.pixabay.com/photo/2017/06/26/19/03/news-2444778_640.jpg",
//     title:
//         "Who Is Ruja Ignatova? ‘Cryptoqueen’ On FBI’s Top Ten Most Wanted Fugitives List",
//     content: '''Ruja Ignatova, also known as the “Cryptoqueen”,
//           defrauded investors from four billion dollars by selling a
//           fake cryptocurrency called OneCoin. She was added to the
//           Federal Bureau of Investigation (FBI)’s list of the ten
//           most wanted fugitives. Her life of crime began in 2012
//           when she was convicted of fraud and she is currently
//           on the run from the authorities.''',
//     instructor: "Admin",
//     publishedAt: DateTime.now(),
//   ),
//   News(
//     id: "id",
//     image:
//         "https://cdn.pixabay.com/photo/2017/06/26/19/03/news-2444778_640.jpg",
//     title:
//         "Who Is Ruja Ignatova? ‘Cryptoqueen’ On FBI’s Top Ten Most Wanted Fugitives List",
//     content: '''Ruja Ignatova, also known as the “Cryptoqueen”,
//           defrauded investors from four billion dollars by selling a
//           fake cryptocurrency called OneCoin. She was added to the
//           Federal Bureau of Investigation (FBI)’s list of the ten
//           most wanted fugitives. Her life of crime began in 2012
//           when she was convicted of fraud and she is currently
//           on the run from the authorities.''',
//     instructor: "Admin",
//     publishedAt: DateTime.now(),
//   ),
//   News(
//     id: "id",
//     image:
//         "https://cdn.pixabay.com/photo/2017/06/26/19/03/news-2444778_640.jpg",
//     title:
//         "Who Is Ruja Ignatova? ‘Cryptoqueen’ On FBI’s Top Ten Most Wanted Fugitives List",
//     content: '''Ruja Ignatova, also known as the “Cryptoqueen”,
//           defrauded investors from four billion dollars by selling a
//           fake cryptocurrency called OneCoin. She was added to the
//           Federal Bureau of Investigation (FBI)’s list of the ten
//           most wanted fugitives. Her life of crime began in 2012
//           when she was convicted of fraud and she is currently
//           on the run from the authorities.''',
//     instructor: "Admin",
//     publishedAt: DateTime.now(),
//   ),
//   News(
//     id: "id",
//     image:
//         "https://cdn.pixabay.com/photo/2017/06/26/19/03/news-2444778_640.jpg",
//     title:
//         "Who Is Ruja Ignatova? ‘Cryptoqueen’ On FBI’s Top Ten Most Wanted Fugitives List",
//     content: '''Ruja Ignatova, also known as the “Cryptoqueen”,
//           defrauded investors from four billion dollars by selling a
//           fake cryptocurrency called OneCoin. She was added to the
//           Federal Bureau of Investigation (FBI)’s list of the ten
//           most wanted fugitives. Her life of crime began in 2012
//           when she was convicted of fraud and she is currently
//           on the run from the authorities.''',
//     instructor: "Admin",
//     publishedAt: DateTime.now(),
//   ),
//   News(
//     id: "id",
//     image:
//         "https://cdn.pixabay.com/photo/2017/06/26/19/03/news-2444778_640.jpg",
//     title:
//         "Who Is Ruja Ignatova? ‘Cryptoqueen’ On FBI’s Top Ten Most Wanted Fugitives List",
//     content: '''Ruja Ignatova, also known as the “Cryptoqueen”,
//           defrauded investors from four billion dollars by selling a
//           fake cryptocurrency called OneCoin. She was added to the
//           Federal Bureau of Investigation (FBI)’s list of the ten
//           most wanted fugitives. Her life of crime began in 2012
//           when she was convicted of fraud and she is currently
//           on the run from the authorities.''',
//     instructor: "Admin",
//     publishedAt: DateTime.now(),
//   ),
// ];
// List<News> unreadNewsList = [
//   News(
//     id: "id",
//     image:
//         "https://cdn.pixabay.com/photo/2017/06/26/19/03/news-2444778_640.jpg",
//     title:
//         "Who Is Ruja Ignatova? ‘Cryptoqueen’ On FBI’s Top Ten Most Wanted Fugitives List",
//     content: '''Ruja Ignatova, also known as the “Cryptoqueen”,
//           defrauded investors from four billion dollars by selling a
//           fake cryptocurrency called OneCoin. She was added to the
//           Federal Bureau of Investigation (FBI)’s list of the ten
//           most wanted fugitives. Her life of crime began in 2012
//           when she was convicted of fraud and she is currently
//           on the run from the authorities.''',
//     instructor: "Admin",
//     publishedAt: DateTime.now(),
//   ),
//   News(
//     id: "id",
//     image:
//         "https://cdn.pixabay.com/photo/2017/06/26/19/03/news-2444778_640.jpg",
//     title:
//         "Who Is Ruja Ignatova? ‘Cryptoqueen’ On FBI’s Top Ten Most Wanted Fugitives List",
//     content: '''Ruja Ignatova, also known as the “Cryptoqueen”,
//           defrauded investors from four billion dollars by selling a
//           fake cryptocurrency called OneCoin. She was added to the
//           Federal Bureau of Investigation (FBI)’s list of the ten
//           most wanted fugitives. Her life of crime began in 2012
//           when she was convicted of fraud and she is currently
//           on the run from the authorities.''',
//     instructor: "Admin",
//     publishedAt: DateTime.now(),
//   ),
//   News(
//     id: "id",
//     image:
//         "https://cdn.pixabay.com/photo/2017/06/26/19/03/news-2444778_640.jpg",
//     title:
//         "Who Is Ruja Ignatova? ‘Cryptoqueen’ On FBI’s Top Ten Most Wanted Fugitives List",
//     content: '''Ruja Ignatova, also known as the “Cryptoqueen”,
//           defrauded investors from four billion dollars by selling a
//           fake cryptocurrency called OneCoin. She was added to the
//           Federal Bureau of Investigation (FBI)’s list of the ten
//           most wanted fugitives. Her life of crime began in 2012
//           when she was convicted of fraud and she is currently
//           on the run from the authorities.''',
//     instructor: "Admin",
//     publishedAt: DateTime.now(),
//   ),
// ];
