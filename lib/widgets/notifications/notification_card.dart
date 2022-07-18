import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:she_can/helper/colors_res.dart';
import 'package:she_can/models/notification.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    Key? key,
    required this.notification,
  }) : super(key: key);

  final NotificationItem notification;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('EEE, M/d/y');
    return ListTile(
      title: Text(
          "${notification.sendAt.hour}:${notification.sendAt.minute} ${formatter.format(notification.sendAt)}",
          style: const TextStyle(
            fontSize: 12,
            color: ColorsRes.appcolor,
          )),
      subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(notification.title,
                style: const TextStyle(
                    fontSize: 15, color: ColorsRes.introTitlecolor)),
            const SizedBox(height: 10),
            Text(notification.message,
                style: const TextStyle(
                  fontSize: 15,
                  color: ColorsRes.introMessagecolor,
                )),
            const SizedBox(height: 2),
            Text("-${notification.sendBy}",
                style: const TextStyle(
                  fontSize: 8,
                  color: ColorsRes.introMessagecolor,
                )),
            const SizedBox(height: 10),
            const Divider(
              height: 5,
              thickness: 1,
            )
          ]),
      isThreeLine: true,
    );
  }
}
