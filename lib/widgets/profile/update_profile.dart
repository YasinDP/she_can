import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:she_can/providers/auth.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({
    Key? key,
    required this.onNameChanged,
    required this.onPasswordChanged,
    required this.onCurrentPasswordChanged,
  }) : super(key: key);

  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onPasswordChanged;
  final ValueChanged<String> onCurrentPasswordChanged;

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final authProvider = Provider.of<AuthNotifier>(context);
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
                    onChanged: (value) => onNameChanged(value),
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    initialValue: authProvider.currentUser!.username,
                    autofocus: true,
                    readOnly: true,
                    decoration: const InputDecoration(labelText: 'Username'),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    autofocus: true,
                    onChanged: (value) => onNameChanged(value),
                    decoration: const InputDecoration(
                        labelText: 'New Password',
                        hintText: "Enter new password to update"),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    autofocus: true,
                    obscureText: true,
                    onChanged: (value) => onCurrentPasswordChanged(value),
                    decoration:
                        const InputDecoration(labelText: 'Current Password'),
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
