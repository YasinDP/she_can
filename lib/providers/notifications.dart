import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:she_can/models/notification.dart';
import 'package:she_can/providers/auth.dart';

class NotificationsNotifier with ChangeNotifier {
  final firestore = FirebaseFirestore.instance.collection("notifications");

  Stream<List<NotificationItem>> getAllNews() => firestore.snapshots().map(
        (event) => event.docs
            .map((doc) => NotificationItem.fromJson(doc.data()))
            .toList(),
      );

  void addNotification({
    required String title,
    required String message,
  }) async {
    final docNots = firestore.doc();
    NotificationItem item = NotificationItem(
      id: docNots.id,
      title: title,
      message: message,
      sendAt: DateTime.now(),
      sendBy: AuthNotifier().currentUser!.username,
    );
    print("=========> Notification is ${item.toJson()}");
    docNots.set(item.toJson());
  }

  void deleteNotification({
    required String id,
  }) async {
    final docNots = firestore.doc(id);
    print("=========> Notification is $docNots");
    docNots.delete();
  }
}
