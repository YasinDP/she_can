import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:she_can/models/news.dart';
import 'package:she_can/models/user.dart';
import 'package:she_can/providers/auth.dart';
import 'package:she_can/providers/user.dart';

class NewsNotifier with ChangeNotifier {
  final firestore = FirebaseFirestore.instance.collection("news");

  Stream<List<News>> getAllNews() => firestore.snapshots().map(
      (event) => event.docs.map((doc) => News.fromJson(doc.data())).toList());

  Stream<List<News?>> getMyNews() =>
      firestore.snapshots().map((event) => event.docs.map((doc) {
            News news = News.fromJson(doc.data());
            if (news.instructor ==
                (AuthNotifier().currentUser == null
                    ? UserProvider.currentUser!.username
                    : AuthNotifier().currentUser!.name)) {
              return news;
            }
          }).toList());

  void addNews({
    required String image,
    required String title,
    required String content,
  }) async {
    final docNews = firestore.doc();
    User? currentUser = AuthNotifier().currentUser ?? UserProvider.currentUser;
    News item = News(
      id: docNews.id,
      image: image,
      title: title,
      content: content,
      instructor: currentUser!.username,
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
