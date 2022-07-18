import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:she_can/models/user.dart';
import 'package:she_can/providers/user.dart';

class AuthNotifier with ChangeNotifier {
  User? _currentUser;
  User? get currentUser => _currentUser;

  final firestore = FirebaseFirestore.instance.collection("users");

  Future<bool> isUsernameTaken(String username) async {
    QuerySnapshot query =
        await firestore.where('username', isEqualTo: username).get();
    return query.docs.isNotEmpty;
  }

  Future<void> registerUser({
    required String name,
    required String username,
    required String password,
    required bool isInstructor,
  }) async {
    final docUser = firestore.doc();
    User item = User(
      id: docUser.id,
      name: name,
      username: username,
      password: password,
      isInstructor: isInstructor,
    );
    debugPrint("=========> User is ${item.toJson()}");
    _currentUser = item;
    UserProvider.currentUser = _currentUser;
    notifyListeners();
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user", jsonEncode(item));
    docUser.set(item.toJson());
  }

  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      prefs.remove("user");
      _currentUser = null;
      UserProvider.currentUser = _currentUser;
      notifyListeners();
    } catch (e) {
      debugPrint("error logging out user: $e");
    }
  }

  Future<String?> loginUser(
      {required String username, required String password}) async {
    QuerySnapshot query =
        await firestore.where('username', isEqualTo: username).get();
    if (query.docs.isNotEmpty) {
      User user =
          User.fromJson(query.docs.first.data() as Map<String, dynamic>);
      if (password == user.password) {
        _currentUser = user;
        UserProvider.currentUser = _currentUser;
        notifyListeners();
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("user", jsonEncode(user));
        return null;
      } else {
        return "Wrong password";
      }
    } else {
      return "Username doesnt exist. Please register if you are a new user";
    }
  }

  Future<void> updateName(String name) async {
    final docUser = firestore.doc(_currentUser!.id);
    User newUser = User(
        id: _currentUser!.id,
        name: name,
        username: _currentUser!.username,
        password: _currentUser!.password,
        isInstructor: _currentUser!.isInstructor);
    docUser.update(newUser.toJson());
  }

  Future<void> updatePassword(String password) async {
    final docUser = firestore.doc(_currentUser!.id);
    User newUser = User(
        id: _currentUser!.id,
        name: _currentUser!.name,
        username: _currentUser!.username,
        password: password,
        isInstructor: _currentUser!.isInstructor);
    docUser.update(newUser.toJson());
  }

  Future<void> fetchCurrentUserProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userValueString = prefs.getString("user");
    if (userValueString != null) {
      Map<String, dynamic> userMap = jsonDecode(userValueString);
      try {
        _currentUser = User.fromJson(userMap);
        UserProvider.currentUser = _currentUser;
        debugPrint("current user is ${_currentUser!.toJson()}");
        notifyListeners();
      } catch (e) {
        debugPrint("error in fetchCurrentUserProfile is : $e");
      }
    }
  }

  Stream<bool> userStatus() async* {
    await fetchCurrentUserProfile();
    if (_currentUser == null) {
      yield false;
    } else {
      yield true;
    }
  }
}
