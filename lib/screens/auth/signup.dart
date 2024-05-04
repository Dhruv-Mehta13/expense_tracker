import 'package:expense_tracker/constants/colors.dart';
import 'package:expense_tracker/data/UserData.dart';
import 'package:expense_tracker/screens/auth/login.dart';
import 'package:expense_tracker/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:get/route_manager.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _usernameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const Text(
                  'Welcome to Expense Tracker!',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    const Text('One stop solution for all your expenses',
                        style: TextStyle(
                          fontSize: 15,
                          color: secondaryTextColor,
                        )),
                  ],
                ),
                SvgPicture.asset(
                  'assets/svg/login.svg',
                  height: 300,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Username is required';
                      }
                      return null;
                    },
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Username',
                      labelStyle: const TextStyle(color: secondaryTextColor),
                      prefixIcon:
                          const Icon(Icons.person, color: secondaryTextColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email is required';
                      } else if (GetUtils.isEmail(value) == false) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Email',
                      labelStyle: const TextStyle(color: secondaryTextColor),
                      prefixIcon:
                          const Icon(Icons.email, color: secondaryTextColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Password',
                      labelStyle: const TextStyle(color: secondaryTextColor),
                      prefixIcon:
                          const Icon(Icons.password, color: secondaryTextColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }
                    Get.dialog(Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      ],
                    ));

                    UserData.signUpUser(_usernameController.text,
                            _emailController.text, _passwordController.text)
                        .then((value) {
                      if (value.sId != null) {
                        Get.offAll(Home(), transition: Transition.fade);
                      } else {
                        Get.back();
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Error occured while signing up')));
                      }
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign Up',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                      onPressed: () {
                        Get.offAll(const LogIn(), transition: Transition.fade);
                      },
                      child: const Text(
                        'Log In',
                        style: TextStyle(color: primaryColor),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
