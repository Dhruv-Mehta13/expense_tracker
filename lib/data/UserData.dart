import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:expense_tracker/models/Stats.dart';
import 'package:expense_tracker/models/User.dart';
import 'package:expense_tracker/screens/auth/login.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static Future<User> loginUser(String email, String password) async {
    var response = await Dio()
        .post('https://expensetracker-2ru5.onrender.com/api/loginUser', data: {
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      var user = User.fromJson(response.data['data']);
      var sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('userId', user.sId!);
      return user;
    } else {
      return User();
    }
  }

  static Future<User> signUpUser(
      String username, String email, String password) async {
    var response = await Dio()
        .post('https://expensetracker-2ru5.onrender.com/api/createUser', data: {
      'username': username,
      'email': email,
      'password': password,
    });
    if (response.statusCode == 200) {
      var user = User.fromJson(response.data['data']);
      var sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('userId', user.sId!);
      return user;
    } else {
      return User();
    }
  }

  static Future<void> logoutUser() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('userId');
    Get.offAll(() => LogIn());
  }

  static Future<User> getUser() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString('userId');
    print(userId);
    if (userId != null) {
      var response = await Dio()
          .post('https://expensetracker-2ru5.onrender.com/api/loadUser', data: {
        'id': userId,
      });
      if (response.statusCode == 200) {
        return User.fromJson(response.data['data']);
      } else {
        return User();
      }
    } else {
      return User();
    }
  }

  static Future<Stats> loadStats() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var userId = sharedPreferences.getString('userId');
    print(userId);
    if (userId != null) {
      var response = await Dio().post(
          'https://expensetracker-2ru5.onrender.com/api/loadStats',
          data: {
            'id': userId,
          });
      if (response.statusCode == 200) {
        return Stats.fromJson(response.data['data']);
      } else {
        return Stats();
      }
    } else {
      return Stats();
    }
  }
}
