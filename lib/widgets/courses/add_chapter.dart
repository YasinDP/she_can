import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:she_can/helper/colors_res.dart';

class AddChapter extends StatefulWidget {
  const AddChapter({
    Key? key,
    required this.onFilePick,
    required this.onTitleChanged,
    required this.onDescriptionChanged,
    required this.onUrlChanged,
    required this.onDurationChanged,
  }) : super(key: key);

  final ValueChanged<PlatformFile> onFilePick;
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onDescriptionChanged;
  final ValueChanged<String> onUrlChanged;
  final ValueChanged<int> onDurationChanged;
  @override
  State<AddChapter> createState() => _AddChapterState();
}

class _AddChapterState extends State<AddChapter> {
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
      widget.onFilePick(pickedFile!);
    }
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
                  child: TextField(
                    autofocus: true,
                    onChanged: (value) => widget.onTitleChanged(value),
                    decoration: const InputDecoration(
                        labelText: 'Title', hintText: 'Video title..'),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    autofocus: true,
                    minLines: 3,
                    maxLines: 5,
                    onChanged: (value) => widget.onDescriptionChanged(value),
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
                  child: TextField(
                    autofocus: true,
                    onChanged: (value) => widget.onUrlChanged(value),
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
                  child: TextField(
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      int? intValue = int.tryParse(value);
                      if (intValue != null) {
                        widget.onDurationChanged(intValue);
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
