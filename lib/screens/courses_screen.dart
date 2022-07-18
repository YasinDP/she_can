import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:she_can/models/user.dart';
import 'package:she_can/providers/auth.dart';
import 'package:she_can/providers/courses.dart';
import 'package:she_can/providers/user.dart';
import 'package:she_can/screens/courses/add_course_screen.dart';
import 'package:she_can/screens/dashboard.dart';
import 'package:she_can/helper/colors_res.dart';
import 'package:she_can/helper/sliver_appbar_delegate.dart';

import 'package:she_can/models/course.dart';
import 'package:she_can/widgets/courses/course_card.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CoursesScreenState();
  }
}

class CoursesScreenState extends State<CoursesScreen>
    with TickerProviderStateMixin {
  late CoursesNotifier courseProvider;
  ScrollController? scrollController;
  TabController? _controller;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController!.addListener(() => setState(() {}));
    _controller = TabController(length: 2, vsync: this);

    _controller!.addListener(() {
      setState(() {
        _selectedIndex = _controller!.index;
      });
    });
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      //DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void didChangeDependencies() {
    courseProvider = Provider.of<CoursesNotifier>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    scrollController!.dispose();
    super.dispose();
  }

  Widget allCourses() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 60),
        child: StreamBuilder<List<Course>>(
            stream: courseProvider.getAllCourses(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Course> courses = snapshot.data!;
                return courses.isNotEmpty
                    ? GridView.builder(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10, top: 10),
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: courses.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CourseCard(course: courses[index]);
                        })
                    : Container(
                        width: width,
                        height: height * 0.6,
                        padding: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 20),
                        child: const Center(
                          child: Text(
                            "No courses are available at the moment! Pls check back later.",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
              } else {
                return Container(
                  width: width,
                  height: height * 0.6,
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: const Center(
                    child: Text(
                      "No courses are available at the moment! Pls check back later.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }

  Widget myCourses() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 60),
        child: StreamBuilder<List<Course?>>(
            stream: courseProvider.getMyCourses(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Course> courses =
                    snapshot.data!.whereType<Course>().toList();
                return courses.isNotEmpty
                    ? GridView.builder(
                        padding: const EdgeInsets.only(
                            bottom: 10, left: 10, right: 10, top: 10),
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: courses.length,
                        itemBuilder: (BuildContext context, int index) {
                          return CourseCard(course: courses[index]);
                        })
                    : Container(
                        width: width,
                        height: height * 0.6,
                        padding: const EdgeInsets.symmetric(
                            vertical: 40, horizontal: 20),
                        child: const Center(
                          child: Text(
                            "You havent created any courses of your own yet! Login as an instructor to add courses now",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
              } else {
                return Container(
                  width: width,
                  height: height * 0.6,
                  padding:
                      const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: const Center(
                    child: Text(
                      "You havent created any courses of your own yet! Login as an instructor to add courses now",
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }

  Widget courseMenu() {
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              systemOverlayStyle: SystemUiOverlayStyle.light,
              shadowColor: Colors.transparent,
              snap: false,
              pinned: true,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: const Text("",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )), //Text
                  background: SvgPicture.asset(
                    "assets/images/topback.svg",
                    height: MediaQuery.of(context).size.width,
                    // fit: BoxFit.cover,
                  ) //Images.network
                  ), //FlexibleSpaceBar
              expandedHeight: 0,
              backgroundColor: ColorsRes.bgcolor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: ColorsRes.appcolor),
                tooltip: 'Back',
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const Dashboard(),
                    ),
                  );
                },
              ), //IconButton
            ),
            SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                  TabBar(
                    indicatorColor: ColorsRes.appcolor,
                    indicatorWeight: 2,
                    controller: _controller,
                    labelColor: ColorsRes.appcolor,
                    unselectedLabelColor: ColorsRes.tabItemColor,
                    tabs: const [
                      Tab(
                        child: Text("ALL",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                      ),
                      Tab(
                        child: Text("MY COURSES",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                      ),
                    ],
                  ),
                )),
          ];
        },
        body: TabBarView(
          controller: _controller,
          children: <Widget>[
            allCourses(),
            myCourses(),
            // savedCourses(),
          ],
        ),
      ), //<Widget>[]
    );
  }

  @override
  Widget build(BuildContext context) {
    User? currentUser =
        context.watch<AuthNotifier>().currentUser ?? UserProvider.currentUser;
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
        body: courseMenu(),
        floatingActionButton: !currentUser!.isInstructor
            ? null
            : Container(
                margin: const EdgeInsets.only(bottom: 70),
                child: FloatingActionButton(
                  onPressed: () => Navigator.of(context)
                      .pushNamed(AddCourseScreen.routeName),
                  backgroundColor: ColorsRes.appcolor,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                )),
      ),
    );
  }
}
