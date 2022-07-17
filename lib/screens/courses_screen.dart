import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:she_can/screens/courses/add_course_screen.dart';
import 'package:she_can/screens/dashboard.dart';
import 'package:she_can/helper/colors_res.dart';
import 'package:she_can/helper/design_config.dart';
import 'package:she_can/helper/sliver_appbar_delegate.dart';

import 'package:she_can/models/course.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CoursesScreenState();
  }
}

class CoursesScreenState extends State<CoursesScreen>
    with TickerProviderStateMixin {
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
  void dispose() {
    scrollController!.dispose();
    super.dispose();
  }

  Widget allCourses() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 60),
      child: GridView.count(
        padding: const EdgeInsets.only(bottom: 10, left: 10, right: 0, top: 10),
        crossAxisCount: 2,
        shrinkWrap: true,
        childAspectRatio: 0.8,
        physics: const ClampingScrollPhysics(),
        children: List.generate(allCourseList.length, (index) {
          Course allCourse = allCourseList[index];
          return SizedBox(
              child: GestureDetector(
                  child: Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      margin: const EdgeInsets.only(bottom: 12, right: 10),
                      decoration: DesignConfig.boxDecorationContainer(
                          ColorsRes.white, 10),
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Expanded(
                              child: DesignConfig.displayImage(
                                allCourseList[index].thumbnail ??
                                    "https://prod-discovery.edx-cdn.org/media/course/image/52bf4539-6137-4968-9605-6c32414dcdc4-7e805a266b31.small.png",
                                double.maxFinite,
                                double.maxFinite,
                              ),
                            ),
                            DesignConfig.displayCourseTitle(allCourse.name, 2),
                            Container(
                                margin: const EdgeInsets.only(left: 10, top: 5),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  allCourseList[index].instructor,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: ColorsRes.introMessagecolor,
                                      fontSize: 10),
                                  textAlign: TextAlign.left,
                                )),
                            const SizedBox(height: 5)
                          ])),
                  onTap: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => CourseDetailActivityMobile(
                    //           id: index,
                    //           type: "allcourse",
                    //         )));
                  }));
        }),
      ),
    );
  }

  Widget myCourses() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 60),
      child: ListView.builder(
        padding:
            const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
        shrinkWrap: true,
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          Course item = myCourseList[index];
          return GestureDetector(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => CourseDetailActivityMobile(
              //           id: index,
              //           type: "mycourse",
              //         )));
            },
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: const EdgeInsets.only(bottom: 12),
              decoration:
                  DesignConfig.boxDecorationContainer(ColorsRes.white, 10),
              child: IntrinsicHeight(
                child: Row(children: <Widget>[
                  DesignConfig.displayImage(
                      myCourseList[index].thumbnail ??
                          "https://prod-discovery.edx-cdn.org/media/course/image/52bf4539-6137-4968-9605-6c32414dcdc4-7e805a266b31.small.png",
                      100,
                      100),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        DesignConfig.displayCourseTitle(
                            myCourseList[index].name, 2),
                        DesignConfig.displayCourseInstructor(item),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          );
        },
        itemCount: myCourseList.length,
      ),
    );
  }

  Widget savedCourses() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 60),
      child: ListView.builder(
        padding:
            const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
        shrinkWrap: true,
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          Course item = savedCourseList[index];
          return GestureDetector(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => CourseDetailActivityMobile(
              //           id: index,
              //           type: "savecourse",
              //         )));
            },
            child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              margin: const EdgeInsets.only(bottom: 12),
              decoration:
                  DesignConfig.boxDecorationContainer(ColorsRes.white, 10),
              child: IntrinsicHeight(
                child: Row(children: <Widget>[
                  DesignConfig.displayImage(
                      savedCourseList[index].thumbnail ??
                          "https://prod-discovery.edx-cdn.org/media/course/image/52bf4539-6137-4968-9605-6c32414dcdc4-7e805a266b31.small.png",
                      100,
                      100),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        DesignConfig.displayCourseTitle(
                            savedCourseList[index].name, 2),
                        DesignConfig.displayCourseInstructor(
                            savedCourseList[index]),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          );
        },
        itemCount: savedCourseList.length,
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
        floatingActionButton: Container(
            margin: const EdgeInsets.only(bottom: 70),
            child: FloatingActionButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(AddCourseScreen.routeName),
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
