import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class AuthViewModel extends ChangeNotifier {
  final SharedPreferences prefs;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  AuthViewModel({required this.prefs});
  Future<void> signup(String email, String password, String name) async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 3));
    final userInfo = {"email": email, "password": password, "name": name};
    await prefs.setString('userInfo', const JsonEncoder().convert(userInfo));
    isLoading = false;
  }

  Future<bool> login(String email, String password) async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 3));
    final userInfoJson = prefs.getString('userInfo');
    isLoading = false;
    if (userInfoJson == null) {
      return false;
    }
    Map<String, dynamic> userInfo = const JsonDecoder().convert(userInfoJson);
    String? storedEmail = userInfo['email'];
    String? storedPassword = userInfo['password'];

    if (storedEmail == email && storedPassword == password) {
      return true;
    }
    return false;
  }

  User getUser() {
    final userInfoJson = prefs.getString('userInfo');
    Map<String, dynamic> userInfo = const JsonDecoder().convert(userInfoJson!);
    return User(
        name: userInfo['name'],
        email: userInfo['email'],
        profilePicture: userInfo['profilePicture']);
  }

  Future<void> logout() async {
    await prefs.remove('userInfo');
    await prefs.remove("favorites");
  }

  Future<void> updateUser(String email, String name, String? profilePicture) async {
    isLoading = true;
    await Future.delayed(const Duration(seconds: 3));
    final userInfoJson = prefs.getString('userInfo');
    Map<String, dynamic> userInfo = const JsonDecoder().convert(userInfoJson!);
    userInfo['email'] = email;
    userInfo['name'] = name;
    if (profilePicture != null) {
      userInfo['profilePicture'] = profilePicture;
    }
    await prefs.setString('userInfo', const JsonEncoder().convert(userInfo));
    isLoading = false;
  }

  bool get isUserLoggedIn {
    return prefs.getString('userInfo') != null;
  }
}
