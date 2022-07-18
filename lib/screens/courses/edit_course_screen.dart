import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:she_can/helper/colors_res.dart';
import 'package:she_can/helper/functions.dart';
import 'package:she_can/models/chapter.dart';
import 'package:she_can/models/course.dart';
import 'package:she_can/models/course_category.dart';
import 'package:she_can/providers/courses.dart';
import 'package:she_can/widgets/courses/add_chapter.dart';
import 'package:she_can/widgets/courses/update_chapter.dart';

class UpdateCourseScreen extends StatefulWidget {
  static const String routeName = "/update-course";
  const UpdateCourseScreen({Key? key}) : super(key: key);

  @override
  State<UpdateCourseScreen> createState() => _UpdateCourseScreenState();
}

class _UpdateCourseScreenState extends State<UpdateCourseScreen> {
  final TextEditingController titleEditingController = TextEditingController();
  final TextEditingController descriptionEditingController =
      TextEditingController();
  final TextEditingController categoryEditingController =
      TextEditingController();
  PlatformFile? courseFile;

  bool _addingCourse = false;

  final List<Chapter> _courseChapters = [];

  late Course course;
  PlatformFile? pickedFile;
  String? title;
  String? description;
  String? url;
  int? duration;

  @override
  void didChangeDependencies() {
    course = ModalRoute.of(context)!.settings.arguments as Course;
    titleEditingController.text = course.name;
    descriptionEditingController.text = course.description ?? "";
    categoryEditingController.text = course.category.name;
    _courseChapters.clear();
    _courseChapters.addAll(course.chapters);

    super.didChangeDependencies();
  }

  Future<void> selectCourseFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowedExtensions: ["jpg", "png", "jpeg"],
      type: FileType.custom,
    );

    if (result == null) {
      return;
    } else {
      setState(() {
        courseFile = result.files.first;
      });
    }
  }

  void reorderData(int oldindex, int newindex) {
    setState(() {
      if (newindex > oldindex) {
        newindex -= 1;
      }
      final chapter = _courseChapters.removeAt(oldindex);
      _courseChapters.insert(newindex, chapter);
    });
  }

  _showDialog() async {
    await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        title: const Text(
          "Add Chapter",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorsRes.appcolor,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: AddChapter(
          onFilePick: (platformFile) =>
              setState(() => pickedFile = platformFile),
          onTitleChanged: (value) => title = value,
          onDescriptionChanged: (value) => description = value,
          onUrlChanged: (value) => url = value,
          onDurationChanged: (value) => duration = value,
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
                FocusScope.of(context).unfocus();
                if (title == null || url == null) {
                  showSnackBar(context,
                      message: "Pls fill in mandatory fields Title and Url");
                  return;
                } else {
                  setState(() {
                    _courseChapters.add(Chapter(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      image: pickedFile?.path,
                      title: title!,
                      description: description,
                      url: url!,
                      minutes: duration,
                      createdAt: DateTime.now(),
                    ));

                    url = null;
                    pickedFile = null;
                    title = null;
                    description = null;
                    duration = null;
                  });
                }
                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  _showUpdateDialog(Chapter chapter) async {
    Chapter newChapter = chapter;
    await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        title: const Text(
          "Update Chapter",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorsRes.appcolor,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: UpdateChapter(
          chapter: chapter,
          onUpdate: (value) => newChapter = value,
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
                FocusScope.of(context).unfocus();
                setState(() {
                  _courseChapters[_courseChapters.indexOf(chapter)] =
                      newChapter;
                });

                Navigator.pop(context);
              })
        ],
      ),
    );
  }

  void _updateCourse() async {
    setState(() {
      _addingCourse = true;
    });
    final coursesProvider =
        Provider.of<CoursesNotifier>(context, listen: false);
    String name = titleEditingController.text;
    String description = descriptionEditingController.text;

    coursesProvider.updateCourse(
      image: courseFile,
      name: name,
      description: description,
      chapters: _courseChapters,
      category: CourseCategory(name: categoryEditingController.text),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: ColorsRes.appcolor,
        title: const Text(
          "Update Course",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        actions: [
          _addingCourse
              ? const CircularProgressIndicator()
              : IconButton(
                  onPressed: _updateCourse,
                  icon: const Icon(Icons.save),
                ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: width,
        height: height,
        child: Column(
          children: [
            const SizedBox(height: 10),
            InkWell(
              onTap: selectCourseFile,
              child: courseFile != null
                  ? Container(
                      color: ColorsRes.appcolor,
                      // child: Text(pickedFile!.name),
                      child: Image.file(
                        File(courseFile!.path!),
                        width: width,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    )
                  : course.thumbnail != null
                      ? Container(
                          color: ColorsRes.appcolor,
                          // child: Text(pickedFile!.name),
                          child: Image.network(
                            course.thumbnail!,
                            width: width,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          decoration: BoxDecoration(
                            color: ColorsRes.appcolor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                              child: Text(
                            "Select Thumbnail",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                        ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              textEditingController: titleEditingController,
              label: "Title",
            ),
            const SizedBox(height: 10),
            CustomTextField(
              textEditingController: descriptionEditingController,
              label: "Description",
            ),
            const SizedBox(height: 10),
            CustomTextField(
              textEditingController: categoryEditingController,
              label: "Category",
            ),
            Divider(
              height: 40,
              color: Colors.grey.withOpacity(0.3),
              thickness: 1,
            ),
            Expanded(
                child: _courseChapters.isNotEmpty
                    ? ReorderableListView.builder(
                        itemCount: _courseChapters.length,
                        onReorder: reorderData,
                        itemBuilder: (context, index) => Container(
                          key: Key(_courseChapters[index].id),
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: ColorsRes.bgcolor,
                          ),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: ColorsRes.appcolor,
                              backgroundImage: isNetworkUrl(
                                      _courseChapters[index].image ?? "")
                                  ? NetworkImage(_courseChapters[index].image!)
                                  : null,
                            ),
                            title: Text(_courseChapters[index].title),
                            subtitle: Text(
                              _courseChapters[index].description == null
                                  ? "..no description added yet.."
                                  : _courseChapters[index].description!.length >
                                          50
                                      ? "${_courseChapters[index].description!.substring(0, 50)}..."
                                      : _courseChapters[index].description!,
                            ),
                            trailing: SizedBox(
                              width: 60,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () => _showUpdateDialog(
                                          _courseChapters[index]),
                                      child: const Icon(
                                        Icons.edit,
                                        color: Colors.orangeAccent,
                                      )),
                                  InkWell(
                                      onTap: () => setState(() =>
                                          _courseChapters.removeAt(index)),
                                      child: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : const Center(
                        child: Text(
                          "This course doesnt have any chapters yet !! Click on the add icon to start adding chapters",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
          ],
        ),
      ),
      floatingActionButton: ElevatedButton(
        onPressed: _showDialog,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ColorsRes.appcolor),
        ),
        child: SizedBox(
          width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              Text(
                "ADD CHAPTERS",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.textEditingController,
    required this.label,
  }) : super(key: key);

  final TextEditingController textEditingController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
            fontWeight: FontWeight.w500, color: ColorsRes.appcolor),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorsRes.appcolor, width: 1.5),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorsRes.appcolor, width: 1.5),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorsRes.appcolor, width: 1.5),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: ColorsRes.appcolor, width: 2.0),
        ),
      ),
    );
  }
}
