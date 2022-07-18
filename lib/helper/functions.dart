import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

bool isNetworkUrl(String url) {
  // Regex to check valid URL
  RegExp reg = RegExp(
    "((http|https)://)(www.)?[a-zA-Z0-9@:%._\\+~#?&//=]{2,256}\\.[a-z]{2,6}\\b([-a-zA-Z0-9@:%._\\+~#?&//=]*)",
    caseSensitive: false,
  );

  // If the URL
  // is empty return false
  if (url.isEmpty) {
    return false;
  }

  // Return true if the URL
  // matched the ReGex
  if (reg.hasMatch(url)) {
    return true;
  } else {
    return false;
  }
}
