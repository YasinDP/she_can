import 'package:flutter/material.dart';
import 'package:she_can/helper/colors_res.dart';
import 'package:she_can/helper/design_config.dart';
import 'package:she_can/models/course.dart';
import 'package:she_can/screens/courses/course_detail_screen.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    Key? key,
    required this.course,
  }) : super(key: key);

  final Course course;

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(CourseDetailsScreen.routeName, arguments: course);
      },
      child: Container(
          // width: width,
          // height: 160,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: const EdgeInsets.only(bottom: 12, right: 10),
          decoration: DesignConfig.boxDecorationContainer(ColorsRes.white, 10),
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Expanded(
                  child: DesignConfig.displayImage(
                    course.thumbnail ??
                        "https://prod-discovery.edx-cdn.org/media/course/image/52bf4539-6137-4968-9605-6c32414dcdc4-7e805a266b31.small.png",
                    double.maxFinite,
                    double.maxFinite,
                  ),
                ),
                DesignConfig.displayCourseTitle(course.name, 2),
                Container(
                    margin: const EdgeInsets.only(left: 10, top: 5),
                    alignment: Alignment.topLeft,
                    child: Text(
                      course.instructor,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: ColorsRes.introMessagecolor, fontSize: 10),
                      textAlign: TextAlign.left,
                    )),
                const SizedBox(height: 5)
              ])),
    );
  }
}
