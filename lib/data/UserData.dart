import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:expense_tracker/models/Expense.dart';
import 'package:expense_tracker/models/Stats.dart';
import 'package:expense_tracker/models/User.dart';
import 'package:expense_tracker/screens/auth/login.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static Future<User> loginUser(String email, String password) async {
    try {
      var response = await Dio().post(
          'https://expensetracker-2ru5.onrender.com/api/loginUser',
          data: {
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
    } catch (e) {
      print(e);
      return User();
    }
  }

  static Future<User> signUpUser(
      String username, String email, String password) async {
    try {
      var response = await Dio().post(
          'https://expensetracker-2ru5.onrender.com/api/createUser',
          data: {
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
    } catch (e) {
      print(e);
      return User();
    }
  }

  static Future<void> logoutUser() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('userId');
    Get.offAll(() => LogIn());
  }

  static Future<User> getUser() async {
    try {
      var sharedPreferences = await SharedPreferences.getInstance();
      var userId = sharedPreferences.getString('userId');
      print(userId);
      if (userId != null) {
        var response = await Dio().post(
            'https://expensetracker-2ru5.onrender.com/api/loadUser',
            data: {
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
    } catch (e) {
      print(e);
      return User();
    }
  }

  static Future<Stats> loadStats() async {
    try {
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
    } catch (e) {
      print(e);
      return Stats();
    }
  }

  static Future<Expense> addExpense(expense) async {
    try {
      var sharedPreferences = await SharedPreferences.getInstance();
      var userId = sharedPreferences.getString('userId');
      print(userId);
      if (userId != null) {
        var response = await Dio().post(
            'https://expensetracker-2ru5.onrender.com/api/addExpense',
            data: expense.toJson());
        if (response.statusCode == 201) {
          print(response.statusCode);
          return Expense.fromJson(response.data['data']);
        } else {
          print(response.statusCode);
          return Expense();
        }
      } else {
        return Expense();
      }
    } catch (e) {
      print(e);
      return Expense();
    }
  }

  static Future<User> SetBudget(var category, int total) async {
    try {
      var sharedPreferences = await SharedPreferences.getInstance();
      var userId = sharedPreferences.getString('userId');
      print(userId);
      if (userId != null) {
        var response = await Dio().post(
            'https://expensetracker-2ru5.onrender.com/api/updateBudget',
            data: {
              'id': userId,
              'categoryBudgets': {
                "Food & Dining": category['Food & Dining'],
                "Housing": category['Housing'],
                "Transportation": category['Transportation'],
                "Healthcare": category['Healthcare'],
                "Entertainment": category['Entertainment'],
                "Utilities": category['Utilities'],
                "Personal Care": category['Personal Care'],
                "Others": category['Others']
              },
              'monthlyBudget': total
            });
        if (response.statusCode == 200) {
          print(response.data);
          return User.fromJson(response.data['data']);
        } else {
          print(response.data);
          return User();
        }
      } else {
        return User();
      }
    } catch (e) {
      print(e);
      return User();
    }
  }
static Future<List<Expense>> loadExpenses(String date) async {
    try {
      var sharedPreferences = await SharedPreferences.getInstance();
      var userId = sharedPreferences.getString('userId');
      print(userId);
      if (userId != null) {
        var response = await Dio().post(
          'https://expensetracker-2ru5.onrender.com/api/loadExpenses',
          data: {'id': userId, 'date': date},
        );
        if (response.statusCode == 200) {
          List<dynamic> expensesData = response.data['data'];
          List<Expense> expenses = expensesData.map((data) => Expense.fromJson(data)).toList();
          return expenses;
        } else {
          return [];
        }
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
 
