import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:she_can/providers/auth.dart';
import 'package:she_can/providers/notifications.dart';
import 'package:she_can/screens/dashboard.dart';
import 'package:she_can/helper/colors_res.dart';

import 'package:she_can/models/notification.dart';
import 'package:she_can/widgets/notifications/add_notification.dart';
import 'package:she_can/widgets/notifications/notification_card.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NotificationsScreenState();
  }
}

class NotificationsScreenState extends State<NotificationsScreen> {
  late NotificationsNotifier notificationsProvider;

  String? title;
  String? message;

  Future<void> createNotification() async {
    final notificationsProv =
        Provider.of<NotificationsNotifier>(context, listen: false);

    if (title == null || title == "" || message == null || message == "") {
      return;
    } else {
      notificationsProv.addNotification(
        title: title!,
        message: message!,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      //DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void didChangeDependencies() {
    notificationsProvider = Provider.of<NotificationsNotifier>(context);
    super.didChangeDependencies();
  }

  Widget notificationMenu() {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          shadowColor: Colors.transparent,
          snap: false,
          pinned: true,
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text(
                "Notifications",
                style: TextStyle(color: Colors.white),
              ), //Text
              background: SvgPicture.asset(
                "assets/images/topback.svg",
                fit: BoxFit.cover,
              ) //Images.network
              ), //FlexibleSpaceBar
          expandedHeight: 0,
          backgroundColor: ColorsRes.bgcolor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            tooltip: 'Back',
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const Dashboard(),
                ),
              );
            },
          ), //IconButton
        ), //SliverAppBar
        const SliverPadding(padding: EdgeInsets.only(bottom: 20)),
        StreamBuilder<List<NotificationItem>>(
            stream: notificationsProvider.getAllNews(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<NotificationItem> notifications = snapshot.data!;
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => NotificationCard(
                        notification: notifications[index]), //ListTile
                    childCount: notifications.length,
                  ), //SliverChildBuildDelegate
                );
              } else {
                return SliverFillRemaining(
                    child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                      const Icon(
                        Icons.notifications_none_outlined,
                        size: 75,
                        color: ColorsRes.introMessagecolor,
                      ),
                      const SizedBox(height: 22),
                      const Text(
                        "No Notifications",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Nunito-Regular',
                            fontSize: 28,
                            color: ColorsRes.introTitlecolor),
                      ),
                      const SizedBox(height: 25),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: const Text(
                            "We'll notify you when we have any updates",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: 'Nunito-Regular',
                                fontSize: 18,
                                color: ColorsRes.black)),
                      ),
                    ])));
              }
            }),
        const SliverPadding(padding: EdgeInsets.only(bottom: 90)),
      ], //<Widget>[]
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const Dashboard(),
            )) as Future<bool>;
      },
      child: Scaffold(
        backgroundColor: ColorsRes.bgPage,
        resizeToAvoidBottomInset: false,
        body: notificationMenu(),
        floatingActionButton:
            !Provider.of<AuthNotifier>(context).currentUser!.isInstructor
                ? null
                : Container(
                    margin: const EdgeInsets.only(bottom: 70),
                    child: FloatingActionButton(
                      onPressed: _showDialog,
                      backgroundColor: ColorsRes.appcolor,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    )),
      ),
    );
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        title: const Text(
          "Add Notification",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorsRes.appcolor,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: AddNotification(
          onTitleChanged: (value) => title = value,
          onMessageChanged: (value) => message = value,
        ),
        actions: <Widget>[
          ElevatedButton(
              child: const Text('CLOSE'),
              onPressed: () {
                Navigator.pop(context);
              }),
          ElevatedButton(
              child: const Text('ADD'),
              onPressed: () {
                createNotification();
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
