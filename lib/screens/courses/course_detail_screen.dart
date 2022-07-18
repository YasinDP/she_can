import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:she_can/helper/colors_res.dart';
import 'package:she_can/models/chapter.dart';
import 'package:she_can/models/course.dart';
import 'package:she_can/models/user.dart';
import 'package:she_can/providers/auth.dart';
import 'package:she_can/providers/courses.dart';
import 'package:she_can/providers/user.dart';
import 'package:she_can/screens/courses/edit_course_screen.dart';
import 'package:she_can/screens/video_detail_screen.dart';

class CourseDetailsScreen extends StatelessWidget {
  static const String routeName = "/course-details";
  const CourseDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final course = ModalRoute.of(context)!.settings.arguments as Course;
    User currentUser =
        context.watch<AuthNotifier>().currentUser ?? UserProvider.currentUser!;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Course Details",
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: ColorsRes.bgcolor,
        foregroundColor: ColorsRes.appcolor,
        // actions: !Provider.of<AuthNotifier>(context).currentUser!.isInstructor
        actions: currentUser.username != course.instructor
            ? null
            : [
                IconButton(
                  onPressed: () => Navigator.of(context).pushNamed(
                      UpdateCourseScreen.routeName,
                      arguments: course),
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () =>
                      _showDeleteDialog(context, courseId: course.id),
                  icon: const Icon(Icons.delete),
                ),
              ],
      ),
      backgroundColor: ColorsRes.bgcolor,
      body: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
            child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: width,
                height: 120,
                color: ColorsRes.appcolor,
                child: Image.network(
                  course.thumbnail ??
                      "https://prod-discovery.edx-cdn.org/media/course/image/52bf4539-6137-4968-9605-6c32414dcdc4-7e805a266b31.small.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              course.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: ColorsRes.appcolorMaterial,
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Category : ${course.category.name}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: ColorsRes.appcolorMaterial,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Instructor : ${course.instructor}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: ColorsRes.appcolorMaterial,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(course.description ?? ""),
            const SizedBox(height: 12),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: course.chapters.length,
              itemBuilder: (context, index) =>
                  ChapterCard(chapter: course.chapters[index]),
            ),
          ],
        )),
      ),
    );
  }
}

class ChapterCard extends StatelessWidget {
  const ChapterCard({
    Key? key,
    required this.chapter,
  }) : super(key: key);

  final Chapter chapter;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(VideoScreen.routeName, arguments: chapter),
      child: Container(
        width: width,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
                image: DecorationImage(
                    image: NetworkImage(chapter.image ??
                        "https://prod-discovery.edx-cdn.org/media/course/image/52bf4539-6137-4968-9605-6c32414dcdc4-7e805a266b31.small.png"),
                    fit: BoxFit.cover),
                color: ColorsRes.appcolor,
              ),
            ),
            Expanded(
              child: Container(
                height: 90,
                padding: const EdgeInsets.only(left: 10, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chapter.title,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "Duration: ${chapter.minutes ?? '-'} minutes",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 5),
                    Expanded(
                      child: Text(
                        chapter.description ?? "",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

_showDeleteDialog(BuildContext context, {required String courseId}) async {
  final courseProvider = context.read<CoursesNotifier>();
  await showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      title: const Text(
        "Delete Course !?",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: ColorsRes.appcolor,
          fontWeight: FontWeight.w500,
        ),
      ),
      content: const Text(
          "Are you sure you want to delete this course and its chapters?"),
      actions: <Widget>[
        ElevatedButton(
            child: const Text('NO'),
            onPressed: () {
              Navigator.pop(context);
            }),
        ElevatedButton(
            child: const Text('YES'),
            onPressed: () {
              courseProvider.deleteCourse(id: courseId);
              Navigator.pop(context);
              Navigator.pop(context);
            })
      ],
    ),
  );
}
