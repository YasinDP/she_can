import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:she_can/models/news.dart';

class NewsNotifier with ChangeNotifier {
  // final List<News> _news = [];
  // List<News> get news => _news;
  // List<News> get myNews =>
  //     _news.where((item) => item.instructor == "Admin").toList();

  final firestore = FirebaseFirestore.instance.collection("news");

  Stream<List<News>> getAllNews() => firestore.snapshots().map(
      (event) => event.docs.map((doc) => News.fromJson(doc.data())).toList());

  Stream<List<News?>> getMyNews() =>
      firestore.snapshots().map((event) => event.docs.map((doc) {
            News _news = News.fromJson(doc.data());
            if (_news.instructor == "Admin") {
              return _news;
            }
          }).toList());

  void addNews({
    required String image,
    required String title,
    required String content,
  }) async {
    final docNews = firestore.doc();
    News item = News(
      id: docNews.id,
      image: image,
      title: title,
      content: content,
      instructor: "Admin",
      publishedAt: DateTime.now(),
    );
    print("=========> News is ${item.toJson()}");
    docNews.set(item.toJson());
  }

  void deleteNews({
    required String id,
  }) async {
    final docNews = firestore.doc(id);
    print("=========> News is $docNews");
    docNews.delete();
  }
}
