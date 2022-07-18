import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:she_can/helper/colors_res.dart';
import 'package:she_can/models/course.dart';
import 'package:she_can/providers/courses.dart';
import 'package:she_can/widgets/courses/course_card.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = "/search";
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late CoursesNotifier courseProvider;
  String? query;
  bool _init = true;

  @override
  void didChangeDependencies() {
    courseProvider = Provider.of<CoursesNotifier>(context);
    if (_init) {
      query = ModalRoute.of(context)!.settings.arguments as String?;
      _init = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Search Courses"),
        backgroundColor: ColorsRes.bgcolor,
        foregroundColor: ColorsRes.appcolor,
      ),
      backgroundColor: ColorsRes.bgcolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
              ),
              child: TextFormField(
                initialValue: query,
                decoration: InputDecoration(
                  hintText: "Search courses by name or categories",
                  hintStyle: Theme.of(context).textTheme.subtitle2!.merge(
                      const TextStyle(
                          color: Color(0xffBAB5B5), letterSpacing: 0.5)),
                  border: InputBorder.none,
                ),
                onChanged: (value) => setState(() {
                  query = value;
                }),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: StreamBuilder<List<Course?>>(
                    stream: courseProvider.getFilteredCourses(query ?? ""),
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
                                itemCount:
                                    courses.length > 20 ? 20 : courses.length,
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
                                    "Keyword search didnt return any results. Pls try again with another keyword!",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              );
                      } else {
                        return Container(
                          width: width,
                          height: height * 0.6,
                          padding: const EdgeInsets.symmetric(
                              vertical: 40, horizontal: 20),
                          child: const Center(
                            child: Text(
                              "Keyword search didnt return any results. Pls try again with another keyword!",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
