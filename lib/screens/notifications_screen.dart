import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:she_can/screens/dashboard.dart';
import 'package:she_can/helper/colors_res.dart';

import 'package:she_can/models/notification.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NotificationsScreenState();
  }
}

class NotificationsScreenState extends State<NotificationsScreen> {
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

  Widget notificationMenu() {
    return notificationsList.isNotEmpty
        ? CustomScrollView(
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
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => ListTile(
                    title: Text(notificationsList[index].sendAt.toString(),
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
                          Text(notificationsList[index].title,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: ColorsRes.introTitlecolor)),
                          const SizedBox(height: 10),
                          Text(notificationsList[index].message,
                              style: const TextStyle(
                                fontSize: 15,
                                color: ColorsRes.introMessagecolor,
                              )),
                          const SizedBox(height: 10),
                          const Divider(
                            height: 5,
                            thickness: 1,
                          )
                        ]),
                    isThreeLine: true,
                  ), //ListTile
                  childCount: notificationsList.length,
                ), //SliverChildBuildDelegate
              ),
              const SliverPadding(padding: EdgeInsets.only(bottom: 90)),
            ], //<Widget>[]
          )
        : CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                systemOverlayStyle: SystemUiOverlayStyle.light,
                shadowColor: Colors.transparent,
                snap: false,
                pinned: true,
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text(
                      "Notification",
                      style: const TextStyle(
                          color: ColorsRes.introTitlecolor, fontSize: 28),
                    ), //Text
                    background: SvgPicture.network(
                      "assets/images/topback.svg",
                      fit: BoxFit.cover,
                    ) //Images.network
                    ), //FlexibleSpaceBar
                expandedHeight: 0,
                backgroundColor: ColorsRes.bgcolor,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: ColorsRes.appcolor),
                  tooltip: 'Back',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ), //IconButton
              ), //SliverAppBar
              SliverFillRemaining(
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
                    Text(
                      "No Notifications",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: 'Nunito-Regular',
                          fontSize: 28,
                          color: ColorsRes.introTitlecolor),
                    ),
                    const SizedBox(height: 25),
                    Container(
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                          "We'll notify you when we have any updates about yur course",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontFamily: 'Nunito-Regular',
                              fontSize: 18,
                              color: ColorsRes.black)),
                    ),
                  ]))) //SliverList
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
      ),
    );
  }
}
