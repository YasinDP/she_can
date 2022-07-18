import 'package:flutter/material.dart';

class AddNotification extends StatelessWidget {
  const AddNotification({
    Key? key,
    required this.onTitleChanged,
    required this.onMessageChanged,
  }) : super(key: key);

  final ValueChanged<String> onTitleChanged;
  final ValueChanged<String> onMessageChanged;

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.5,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    autofocus: true,
                    onChanged: (value) => onTitleChanged(value),
                    decoration: const InputDecoration(
                        labelText: 'Title', hintText: 'Notification title'),
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
                    onChanged: (value) => onMessageChanged(value),
                    decoration: const InputDecoration(
                        labelText: 'Message', hintText: 'Notification message'),
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
