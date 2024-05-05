import 'package:expense_tracker/constants/colors.dart';
import 'package:expense_tracker/models/Stats.dart';
import 'package:expense_tracker/screens/My_expenses/myExpense.dart';
import 'package:expense_tracker/screens/add_expense.dart/add.dart';
import 'package:expense_tracker/screens/home/app_bar.dart';
import 'package:expense_tracker/screens/home/bottom.dart';
import 'package:expense_tracker/screens/home/category_card_widget.dart';
import 'package:expense_tracker/screens/home/total_card_widget.dart';
import 'package:expense_tracker/screens/set_budget/set_budget.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/data/UserData.dart';
import 'package:expense_tracker/models/User.dart';
import 'package:get/route_manager.dart';

class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  var current_page = 0;
  User? currentUser;
  late String userInitials = '';
  var isDataLoaded = false;
  Stats? stats = Stats();
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  _loadUserData() async {
    User user = await UserData.getUser();
    Stats loadStats = await UserData.loadStats();
    setState(() {
      currentUser = user;
      userInitials = _getInitials(currentUser?.username);
      stats = loadStats;
      isDataLoaded = true;
    });
  }

  // Function to get initials from username
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
      backgroundColor: Colors.white,
      appBar: MyAppBar(
        isDataLoaded: isDataLoaded,
        currentUser: currentUser,
        userInitials: userInitials,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Total_Card(stats!),
            const Padding(
              padding: EdgeInsets.only(top: 20, left: 15, right: 15),
              child: Row(
                children: [
                  Text(
                    'Category Spendings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            isDataLoaded
                ? Column(
                    children: [
                      Category_Card(
                          category_name: 'Food & Dining',
                          spent_amount: stats!.categorySpends!.foodDining,
                          budget: stats!.categoryBudgets!.foodDining,
                          icon: Icons.restaurant),
                      Category_Card(
                          category_name: 'Housing',
                          spent_amount: stats!.categorySpends!.housing,
                          budget: stats!.categoryBudgets!.housing,
                          icon: Icons.home),
                      Category_Card(
                          category_name: 'Transportation',
                          spent_amount: stats!.categorySpends!.transportation,
                          budget: stats!.categoryBudgets!.transportation,
                          icon: Icons.train),
                      Category_Card(
                          category_name: 'Healthcare',
                          spent_amount: stats!.categorySpends!.healthcare,
                          budget: stats!.categoryBudgets!.healthcare,
                          icon: Icons.local_hospital),
                      Category_Card(
                          category_name: 'Entertainment',
                          spent_amount: stats!.categorySpends!.entertainment,
                          budget: stats!.categoryBudgets!.entertainment,
                          icon: Icons.movie_outlined),
                      Category_Card(
                          category_name: 'Personal Care',
                          spent_amount: stats!.categorySpends!.personalCare,
                          budget: stats!.categoryBudgets!.personalCare,
                          icon: Icons.bathtub_outlined),
                      Category_Card(
                          category_name: 'Utilities',
                          spent_amount: stats!.categorySpends!.utilities,
                          budget: stats!.categoryBudgets!.utilities,
                          icon: Icons.electrical_services),
                      Category_Card(
                          category_name: 'Others',
                          spent_amount: stats!.categorySpends!.others,
                          budget: stats!.categoryBudgets!.others,
                          icon: Icons.add),
                    ],
                  )
                : Column(children: [
                    for (var i = 0; i < 8; i++) Shimmer_Category_Card(),
                  ]),
          ],
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
            Get.off(MyExpense(), transition: Transition.cupertino);
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
