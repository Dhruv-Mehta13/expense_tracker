import 'package:expense_tracker/screens/home/bottom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/data/UserData.dart';
import 'package:expense_tracker/models/Stats.dart';
import 'package:expense_tracker/models/User.dart';
import 'package:expense_tracker/screens/add_expense.dart/add.dart';
import 'package:expense_tracker/screens/home/app_bar.dart';
import 'package:expense_tracker/screens/home/home.dart';
import 'package:expense_tracker/constants/colors.dart';

class SetBudget extends StatefulWidget {
  const SetBudget({Key? key}) : super(key: key);

  @override
  State<SetBudget> createState() => _SetBudgetState();
}

class _SetBudgetState extends State<SetBudget> {
  var current_page = 3;
  User? currentUser;
  late String userInitials = '';
  var isDataLoaded = false;

  _loadUserData() async {
    User user = await UserData.getUser();
    Stats loadStats = await UserData.loadStats();
    setState(() {
      currentUser = user;
      userInitials = _getInitials(currentUser?.username);
      var stats = loadStats;
      isDataLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  String _getInitials(String? username) {
    if (username != null) {
      List<String> nameParts = username.split(' ');
      if (nameParts.length > 1) {
        return '${nameParts[0][0]}${nameParts[1][0]}';
      } else {
        return '${nameParts[0][0]}';
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        isDataLoaded: true,
        currentUser: currentUser,
        userInitials: userInitials,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: Column(
            children: [
              SetBudgetCard(category: 'Food & Dining', icon: Icons.restaurant),
              SetBudgetCard(category: 'Housing', icon: Icons.home),
              SetBudgetCard(category: 'Transportation', icon: Icons.train),
              SetBudgetCard(category: 'Healthcare', icon: Icons.local_hospital),
              SetBudgetCard(
                  category: 'Entertainment', icon: Icons.movie_outlined),
              SetBudgetCard(
                  category: 'Personal Care', icon: Icons.bathtub_outlined),
              SetBudgetCard(
                  category: 'Utilities', icon: Icons.electrical_services),
              SetBudgetCard(category: 'Others', icon: Icons.add),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Bottom_Navigation_Bar(
        currentIndex: current_page,
        onTap: (int index) {
          setState(() {
            current_page = index;
          });
          if (index == 0) {
            Get.off(Home(), transition: Transition.cupertino);
          } else if (index == 1) {
            Get.off(Home(), transition: Transition.cupertino);
          } else if (index == 2) {
            Get.off(AddExpense(), transition: Transition.cupertino);
          } else if (index == 3) {
            Get.off(SetBudget(), transition: Transition.cupertino);
          }
        },
      ),
    );
  }
}

class SetBudgetCard extends StatefulWidget {
  final String category;
  final IconData icon;

  const SetBudgetCard({Key? key, required this.category, required this.icon})
      : super(key: key);

  @override
  _SetBudgetCardState createState() => _SetBudgetCardState();
}

class _SetBudgetCardState extends State<SetBudgetCard> {
  late double budgetValue;

  @override
  void initState() {
    super.initState();
    budgetValue = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 15, 15, 0),
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color: Colors.grey.shade300, blurRadius: 5),
        ],
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(
                    widget.icon,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.category,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\u{20B9} 0',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: Slider(
                      value: budgetValue,
                      min: 0,
                      max: 100000,
                      onChanged: (newValue) {
                        setState(() {
                          budgetValue = newValue;
                        });
                      },
                    ),
                  ),
                  Text(
                    '\u{20B9} ${budgetValue.toInt()}',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
