import 'package:flutter/material.dart';
import 'package:she_can/screens/courses_screen.dart';
import 'package:she_can/screens/home_screen.dart';
import 'package:she_can/screens/news_screen.dart';
import 'package:she_can/screens/notifications_screen.dart';
import 'package:she_can/screens/profile_screen.dart';
import 'package:she_can/helper/colors_res.dart';

import 'package:she_can/models/course.dart';
import 'package:she_can/models/tab_item.dart';
// ignore: depend_on_referenced_packages
import 'package:vector_math/vector_math.dart' as vector;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Tween<double> _positionTween;
  late Animation<double> _positionAnimation;

  late AnimationController _fadeOutController;
  late Animation<double> _fadeFabOutAnimation;
  late Animation<double> _fadeFabInAnimation;

  double fabIconAlpha = 1;
  IconData nextIcon = Icons.home;
  IconData activeIcon = Icons.home;

  int currentSelected = 0, id = 0, idvideo = 0, last = 0;
  String title = "";
  List<Course>? items;
  Course? selectedcourse;

  ScrollController? scrollController, scrollControllerLessons;
  double trendingheight = 100;
  double popularheight = 180;
  // FlickManager flickManager;
  bool descTextShowFlag = false;
  DateTime? backButtonPressTime;
  static const snackBarDuration = Duration(seconds: 3);
  static const snackBarDuration1 = Duration(seconds: 1);
  late List<Widget> fragments;

  @override
  void initState() {
    fragments = const [
      HomeScreen(),
      NewsScreen(),
      CoursesScreen(),
      NotificationsScreen(),
      ProfileScreen(),
    ];

    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: TabItemState.animDuration));
    _fadeOutController = AnimationController(
        vsync: this,
        duration:
            const Duration(milliseconds: (TabItemState.animDuration ~/ 5)));

    _positionTween = Tween<double>(begin: -1, end: 0);
    _positionAnimation = _positionTween.animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _fadeFabOutAnimation = Tween<double>(begin: 0, end: 0).animate(
        CurvedAnimation(parent: _fadeOutController, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {
          fabIconAlpha = _fadeFabOutAnimation.value;
        });
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            activeIcon = nextIcon;
          });
        }
      });

    _fadeFabInAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.8, 1, curve: Curves.easeOut)))
      ..addListener(() {
        setState(() {
          fabIconAlpha = _fadeFabInAnimation.value;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> handleback(BuildContext context) async {
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            now.difference(backButtonPressTime!) > snackBarDuration1;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = now;
      setState(() {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Dashboard(),
            ));
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (currentSelected == 0) {
          return Future.value(true);
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => Dashboard(),
            ),
          );

          return Future.value(false);
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        backgroundColor: ColorsRes.bgcolor,
        bottomNavigationBar: bottomBarItem(),
        body: fragments[currentSelected],
      ),
    );
  }

  Widget bottomBarItem() {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          height: 70,
          margin: const EdgeInsets.only(top: 45),
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          decoration: const BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, -1), blurRadius: 8)
          ]),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TabItem(
                  selected: currentSelected == 0,
                  iconData: Icons.home,
                  title: "Home",
                  callbackFunction: () {
                    setState(() {
                      nextIcon = Icons.home;
                      currentSelected = 0;
                      title = "";
                    });
                    _initAnimationAndStart(_positionAnimation.value, -1);
                  }),
              TabItem(
                  selected: currentSelected == 1,
                  iconData: Icons.book,
                  title: "News",
                  callbackFunction: () {
                    setState(() {
                      nextIcon = Icons.book;
                      currentSelected = 1;
                      title = "";
                    });
                    _initAnimationAndStart(_positionAnimation.value, -0.5);
                  }),
              TabItem(
                  selected: currentSelected == 2,
                  iconData: Icons.live_tv_outlined,
                  title: "Course",
                  callbackFunction: () {
                    setState(() {
                      nextIcon = Icons.live_tv_outlined;
                      currentSelected = 2;
                      title = "Course";
                    });
                    _initAnimationAndStart(_positionAnimation.value, 0);
                  }),
              TabItem(
                  selected: currentSelected == 3,
                  iconData: Icons.notifications,
                  title: "Notification",
                  callbackFunction: () {
                    setState(() {
                      nextIcon = Icons.notifications;
                      currentSelected = 3;
                      title = "Notification";
                    });
                    _initAnimationAndStart(_positionAnimation.value, 0.5);
                  }),
              TabItem(
                  selected: currentSelected == 4,
                  iconData: Icons.person,
                  title: "Profile",
                  callbackFunction: () {
                    setState(() {
                      nextIcon = Icons.person;
                      currentSelected = 4;
                      title = "";
                    });
                    _initAnimationAndStart(_positionAnimation.value, 1);
                  })
            ],
          ),
        ),
        IgnorePointer(
          child: Align(
            heightFactor: 1,
            alignment: Alignment(_positionAnimation.value, 0),
            child: FractionallySizedBox(
              widthFactor: 1 / 5,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 90,
                    width: 90,
                    child: ClipRect(
                        clipper: HalfClipper(),
                        child: Center(
                          child: Container(
                              width: 70,
                              height: 70,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12, blurRadius: 8)
                                  ])),
                        )),
                  ),
                  SizedBox(
                      height: 70,
                      width: 90,
                      child: CustomPaint(
                        painter: HalfPainter(),
                      )),
                  SizedBox(
                    height: 60,
                    width: 60,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const LinearGradient(
                              colors: [
                                ColorsRes.secondgradientcolor,
                                ColorsRes.firstgradientcolor,
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          border: Border.all(
                              color: Colors.white,
                              width: 5,
                              style: BorderStyle.none)),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Opacity(
                          opacity: fabIconAlpha,
                          child: Icon(
                            activeIcon,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _initAnimationAndStart(double from, double to) {
    _positionTween.begin = from;
    _positionTween.end = to;

    _animationController.reset();
    _fadeOutController.reset();
    _animationController.forward();
    _fadeOutController.forward();
  }
}

class HalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height / 2);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

class HalfPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect beforeRect = Rect.fromLTWH(0, (size.height / 2) - 10, 10, 10);
    final Rect largeRect = Rect.fromLTWH(10, 0, size.width - 20, 70);
    final Rect afterRect =
        Rect.fromLTWH(size.width - 10, (size.height / 2) - 10, 10, 10);

    final path = Path();
    path.arcTo(beforeRect, vector.radians(0), vector.radians(90), false);
    path.lineTo(20, size.height / 2);
    path.arcTo(largeRect, vector.radians(0), -vector.radians(180), false);
    path.moveTo(size.width - 10, size.height / 2);
    path.lineTo(size.width - 10, (size.height / 2) - 10);
    path.arcTo(afterRect, vector.radians(180), vector.radians(-90), false);
    path.close();

    canvas.drawPath(path, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
