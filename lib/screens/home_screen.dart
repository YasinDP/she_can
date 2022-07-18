import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:she_can/models/course.dart';
import 'package:she_can/helper/colors_res.dart';
import 'package:she_can/helper/design_config.dart';
import 'package:she_can/models/course_category.dart';
import 'package:she_can/providers/courses.dart';
import 'package:she_can/widgets/courses/course_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  late CoursesNotifier courseProvider;
  double trendingheight = 100;
  double popularheight = 200;
  //  double trendingheight = 100;
  //double popularheight = 180;
  late Future<Course> _future;
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
    courseProvider = Provider.of<CoursesNotifier>(context);
    _future = courseProvider.getLatestCourse();
    super.didChangeDependencies();
  }

  Widget displayCategories() {
    return Wrap(
        crossAxisAlignment: WrapCrossAlignment.start,
        spacing: 10,
        runSpacing: 4.0,
        children: List.generate(
            categoryList.length >= 10 ? 10 : categoryList.length,
            (i) => GestureDetector(
                  onTap: () {},
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border:
                              Border.all(color: ColorsRes.introMessagecolor)),
                      padding: const EdgeInsetsDirectional.only(
                          start: 8, end: 8, top: 8, bottom: 8),
                      child: Text(categoryList[i].name.trim(),
                          style: const TextStyle(
                            height: 1.0,
                            color: ColorsRes.introMessagecolor,
                          ))),
                )));
  }

  Widget popularCourses() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return StreamBuilder<List<Course>>(
        stream: courseProvider.getAllCourses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Course> courses = snapshot.data!.reversed.toList();
            return SizedBox(
              width: width,
              height: 160,
              child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  scrollDirection: Axis.horizontal,
                  itemCount: courses.length > 6 ? 6 : courses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SizedBox(
                        width: width * 0.3,
                        height: 160,
                        child: CourseCard(course: courses[index]));
                  }),
            );
          } else {
            return Container(
              width: width,
              height: height * 0.6,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: const Center(
                child: Text(
                  "No courses are available at the moment! Pls check back later.",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        });
  }

  Widget latestCourses() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return StreamBuilder<List<Course>>(
        stream: courseProvider.getAllCourses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Course> courses = snapshot.data!;
            return GridView.builder(
                padding: const EdgeInsets.only(
                    bottom: 10, left: 10, right: 10, top: 10),
                scrollDirection: Axis.vertical,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: courses.length > 4 ? 4 : courses.length,
                itemBuilder: (BuildContext context, int index) {
                  return CourseCard(course: courses[index]);
                });
          } else {
            return Container(
              width: width,
              height: height * 0.2,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: const Center(
                child: Text(
                  "No courses are available at the moment! Pls check back later.",
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
        });
  }

  Widget displayNewCourse() {
    return SizedBox(
      child: FutureBuilder(
        future: _future,
        builder: (ctx, snapshot) {
          print(snapshot);
          if (snapshot.hasData &&
              ConnectionState.done == snapshot.connectionState) {
            Course course = snapshot.data as Course;
            return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: course.chapters.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        margin: const EdgeInsets.only(bottom: 12, right: 10),
                        decoration: DesignConfig.boxDecorationContainer(
                            ColorsRes.white, 10),
                        child: SizedBox(
                            width: 300,
                            child: Row(children: <Widget>[
                              DesignConfig.displayImage(
                                  course.chapters[index].image ??
                                      "https://prod-discovery.edx-cdn.org/media/course/image/52bf4539-6137-4968-9605-6c32414dcdc4-7e805a266b31.small.png",
                                  100,
                                  100),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: DesignConfig.displayCourseTitle(
                                          course.chapters[index].title, 2),
                                    ),
                                    DesignConfig.displayCourseInstructor(
                                        course),
                                  ],
                                ),
                              ),
                            ])),
                      ),
                      onTap: () {
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (context) => CourseDetailActivityMobile(
                        //           id: index, type: "mycourse")));
                      });
                });
          } else {
            // Displaying LoadingSpinner to indicate waiting state
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },

        // Future that needs to be resolved
        // inorder to display something on the Canvas
      ),
    );
  }

  Widget homeMenu() {
    final width = MediaQuery.of(context).size.width;
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          systemOverlayStyle: SystemUiOverlayStyle.light,
          snap: false,
          pinned: true,
          floating: false,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: const Text(
                "",
                style: TextStyle(
                    color: ColorsRes.introTitlecolor, fontSize: 28), //TextStyle
              ), //Text
              background: Stack(children: [
                Container(
                  color: ColorsRes.bgcolor,
                  height: width,
                  child: SizedBox(
                    child: SvgPicture.asset(
                      'assets/images/topback.svg',
                      height: width,
                      width: width,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .13),
                    alignment: Alignment.bottomLeft,
                    child: Column(children: [
                      const SizedBox(height: 20),
                      Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(left: 18, right: 20),
                          child: const Text(
                            "Hello User,",
                            style:
                                TextStyle(color: ColorsRes.white, fontSize: 22),
                          )),
                      const SizedBox(height: 10),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.only(left: 18, right: 20),
                        child: const Text(
                            "What would you like to explore today? Search below.,",
                            style: TextStyle(
                                color: ColorsRes.applightcolor, fontSize: 18)),
                      ),
                    ])),
                InkWell(
                  onTap: () => print("searching.."),
                  child: Container(
                    margin: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: MediaQuery.of(context).size.height * .28),
                    decoration: DesignConfig.boxDecorationContainer(
                        ColorsRes.white, 10),
                    child: Container(
                      height: 43,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16)),
                      child: Row(
                        children: const [
                          Icon(Icons.search, color: Colors.grey),
                          SizedBox(width: 10),
                          Text(
                            "Search here for courses or news..",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ])),
          actions: <Widget>[
            FittedBox(
                child: Container(
                    margin: EdgeInsets.all(
                        MediaQuery.of(context).size.height * .01),
                    alignment: Alignment.bottomLeft,
                    child: Row(children: [
                      Container(
                        margin: const EdgeInsets.only(left: 20),
                        width: 45.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.asset(
                            "assets/images/avatar.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ]))), //IconButton//IconButton
          ], //FlexibleSpaceBar
          expandedHeight: MediaQuery.of(context).size.height * .3,
          backgroundColor: ColorsRes.appcolor,
          leading: Container(
            padding:
                EdgeInsets.only(left: MediaQuery.of(context).size.width * .02),
            child: Wrap(
              alignment: WrapAlignment.spaceAround,
              spacing: 5.0,
              runSpacing: 5.0,
              direction: Axis.vertical, // main axis (rows or columns)
              children: <Widget>[
                Platform.isIOS
                    ? const BackButton(
                        color: ColorsRes.white,
                      )
                    : const Text(""),
                Image.asset("assets/images/logo-horiz.png", fit: BoxFit.fill),
              ],
            ),
          ), //IconButton
        ), //SliverAppBar
        SliverList(
            delegate: SliverChildListDelegate([
          Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                categoryList.isEmpty
                    ? Container()
                    : Padding(
                        padding: const EdgeInsetsDirectional.only(
                            top: 20, start: 10, end: 10),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Row(children: <Widget>[
                                const Text(
                                  "Categories",
                                  style: TextStyle(
                                      color: ColorsRes.appcolor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                const Spacer(), // Defaults to a flex of one.
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 5, top: 5, bottom: 5),
                                  child: GestureDetector(
                                    child: const Text("View all",
                                        style: TextStyle(
                                            color: ColorsRes.appcolor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                    onTap: () {},
                                  ),
                                ),
                              ]),
                              const SizedBox(height: 10),
                              displayCategories(),
                            ])),
                // Padding(
                //     padding: const EdgeInsetsDirectional.only(
                //         top: 15, start: 10, end: 10),
                //     child: Column(
                //         mainAxisSize: MainAxisSize.min,
                //         children: <Widget>[
                //           Row(children: const <Widget>[
                //             Text(
                //               " Courses",
                //               style: TextStyle(
                //                   color: ColorsRes.appcolor,
                //                   fontWeight: FontWeight.bold,
                //                   fontSize: 18),
                //             ),
                //             Spacer(), // Defaults to a flex of one.
                //           ]),
                //           const SizedBox(height: 5),
                //           displayNewCourse(),
                //         ])),
                Padding(
                    padding: const EdgeInsetsDirectional.only(
                        top: 10, start: 10, end: 10),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(children: const <Widget>[
                            Text(
                              "Popular Course",
                              style: TextStyle(
                                  color: ColorsRes.appcolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            Spacer(), // Defaults to a flex of one.
                          ]),
                          popularCourses(),
                        ])),
                Padding(
                    padding: const EdgeInsetsDirectional.only(
                        top: 10, start: 10, end: 10),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Row(children: const <Widget>[
                            Text(
                              "Latest Courses",
                              style: TextStyle(
                                  color: ColorsRes.appcolor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            Spacer(), // Defaults to a flex of one.
                          ]),
                          latestCourses(),
                        ])),
                const SizedBox(height: 60),
              ]),
        ]) //SliverChildBuildDelegate
            )
      ], //<Widget>[]
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsRes.bgPage,
      resizeToAvoidBottomInset: false,
      body: homeMenu(),
    );
  }
}
