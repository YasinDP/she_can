import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:she_can/helper/colors_res.dart';
import 'package:she_can/helper/functions.dart';
import 'package:she_can/models/chapter.dart';

class UpdateChapter extends StatefulWidget {
  const UpdateChapter({
    Key? key,
    required this.chapter,
    required this.onUpdate,
  }) : super(key: key);

  final Chapter chapter;
  final ValueChanged<Chapter> onUpdate;
  @override
  State<UpdateChapter> createState() => _UpdateChapterState();
}

class _UpdateChapterState extends State<UpdateChapter> {
  PlatformFile? pickedFile;

  Future<void> selectFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowedExtensions: ["jpg", "png", "jpeg"],
      type: FileType.custom,
    );

    if (result == null) {
      return;
    } else {
      setState(() {
        pickedFile = result.files.first;
      });
      widget.onUpdate(widget.chapter.copyWith(newImage: pickedFile!.path!));
    }
  }

  @override
  void initState() {
    pickedFile = widget.chapter.image == null
        ? null
        : isNetworkUrl(widget.chapter.image!)
            ? null
            : PlatformFile(
                name: widget.chapter.image!.split('/').last,
                size: 0,
                path: widget.chapter.image,
              );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.5,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: selectFile,
                    child: pickedFile != null
                        ? Container(
                            color: ColorsRes.appcolor,
                            // child: Text(pickedFile!.name),
                            child: Image.file(
                              File(pickedFile!.path!),
                              width: width * 0.8,
                              fit: BoxFit.cover,
                            ),
                          )
                        : isNetworkUrl(widget.chapter.image!)
                            ? Container(
                                color: ColorsRes.appcolor,
                                // child: Text(pickedFile!.name),
                                child: Image.network(
                                  widget.chapter.image!,
                                  width: width * 0.8,
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
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    initialValue: widget.chapter.title,
                    autofocus: true,
                    onChanged: (value) => widget
                        .onUpdate(widget.chapter.copyWith(newTitle: value)),
                    decoration: const InputDecoration(
                        labelText: 'Title', hintText: 'Video title..'),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    initialValue: widget.chapter.description,
                    autofocus: true,
                    minLines: 3,
                    maxLines: 5,
                    onChanged: (value) => widget.onUpdate(
                        widget.chapter.copyWith(newDescription: value)),
                    decoration: const InputDecoration(
                        labelText: 'Description',
                        hintText: 'Video description..'),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    initialValue: widget.chapter.url,
                    autofocus: true,
                    onChanged: (value) =>
                        widget.onUpdate(widget.chapter.copyWith(newUrl: value)),
                    decoration: const InputDecoration(
                        labelText: 'Youtube Url',
                        hintText: 'Youtube video link'),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    initialValue: widget.chapter.minutes == null
                        ? ""
                        : widget.chapter.minutes.toString(),
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      int? intValue = int.tryParse(value);
                      if (intValue != null) {
                        widget.onUpdate(
                            widget.chapter.copyWith(newMinutes: intValue));
                      }
                    },
                    decoration: const InputDecoration(
                        labelText: 'Duration',
                        hintText: 'Duration of video in minutes'),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
