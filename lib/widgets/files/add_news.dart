import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:she_can/helper/colors_res.dart';

class AddNews extends StatefulWidget {
  const AddNews({
    Key? key,
    required this.onFilePick,
    required this.onTitleChanged,
    required this.onContentChanged,
  }) : super(key: key);

  final ValueChanged<PlatformFile> onFilePick;
  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onContentChanged;

  @override
  State<AddNews> createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {
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
                        labelText: 'Headline', hintText: 'News headline..'),
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
                    onChanged: (value) => widget.onContentChanged(value),
                    decoration: const InputDecoration(
                        labelText: 'Content', hintText: 'News content..'),
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
