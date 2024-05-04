import 'package:expense_tracker/constants/colors.dart';
import 'package:expense_tracker/screens/auth/login.dart';
import 'package:expense_tracker/screens/auth/signup.dart';
import 'package:expense_tracker/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
