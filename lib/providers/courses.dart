import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:she_can/models/chapter.dart';
import 'package:she_can/models/course.dart';
import 'package:she_can/models/course_category.dart';

class CoursesNotifier with ChangeNotifier {
  final List<Course> _courses = [];
  List<Course> get courses => _courses;
  List<Course> get myCourses =>
      _courses.where((item) => item.instructor == "Admin").toList();

  final firestore = FirebaseFirestore.instance.collection("courses");

  Stream<List<Course>> getAllCourses() => firestore.snapshots().map(
      (event) => event.docs.map((doc) => Course.fromJson(doc.data())).toList());

  Stream<List<Course?>> getMyCourses() =>
      firestore.snapshots().map((event) => event.docs.map((doc) {
            Course _course = Course.fromJson(doc.data());
            if (_course.instructor == "Admin") {
              return _course;
            }
          }).toList());

  Future<String> uploadFile(
      {required String folder,
      required String fileName,
      required String filePath}) async {
    final path = '$folder/$fileName';
    final file = File(filePath);
    late UploadTask uploadTask;

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask.whenComplete(() => null);

    final urlDownload = await snapshot.ref.getDownloadURL();
    print("=========> urlDownload is $urlDownload");
    return urlDownload;
  }

  Future<Chapter> _getChapterWithOnlineUrl(Chapter chapter) async {
    if (chapter.image != null) {
      String newImage = await uploadFile(
          folder: "chapters",
          fileName: chapter.image!.split("/").toList().last,
          filePath: chapter.image!);
      return chapter.copyWith(newImage: newImage);
    }
    return chapter;
  }

  void addCourse({
    required PlatformFile? image,
    required String name,
    required String? description,
    required List<Chapter> chapters,
    required CourseCategory category,
  }) async {
    final docCourse = firestore.doc();
    List<Chapter> _chaptersWithOnlineThumbnails = [];
    for (var chapter in chapters) {
      _chaptersWithOnlineThumbnails
          .add(await _getChapterWithOnlineUrl(chapter));
    }
    Course item = Course(
        id: docCourse.id,
        name: name,
        description: description,
        thumbnail: image == null
            ? null
            : await uploadFile(
                folder: "courses", fileName: image.name, filePath: image.path!),
        category: category,
        chapters: _chaptersWithOnlineThumbnails,
        instructor: "Admin");
    print("=========> Course is ${item.toJson()}");
    docCourse.set(item.toJson());
  }

  void deleteCourse({
    required String id,
  }) async {
    final docCourse = firestore.doc(id);
    print("=========> News is $docCourse");
    docCourse.delete();
  }
}
