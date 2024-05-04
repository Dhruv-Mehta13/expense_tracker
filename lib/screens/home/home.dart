import 'package:expense_tracker/constants/colors.dart';
import 'package:expense_tracker/models/Stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/data/UserData.dart';
import 'package:expense_tracker/models/User.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/route_manager.dart';
import 'package:getwidget/getwidget.dart';

class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  var current_page = 0;
  User? currentUser;
  late String userInitials = '';
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
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Expanded(
          child: Row(
            children: [
              currentUser != null
                  ? Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: primaryColor,
                          child: Text(
                            userInitials,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    )
                  : SizedBox(),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Welcome, ${currentUser?.username}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        UserData.logoutUser();
                      },
                      icon: Icon(Icons.logout)),
                ],
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Total_Card(),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
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
        ),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
            (Set<MaterialState> states) =>
                states.contains(MaterialState.selected)
                    ? const TextStyle(color: Colors.black, fontSize: 15)
                    : const TextStyle(color: Colors.black, fontSize: 15),
          ),
        ),
        child: NavigationBar(
          backgroundColor: Colors.white,
          selectedIndex: current_page,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          indicatorColor: primaryColor,
          onDestinationSelected: (value) {
            if (value == 0) {
              setState(() {
                current_page = value;
              });
              Get.to(Home(), transition: Transition.cupertino);
            } else if (value == 1) {
              setState(() {
                current_page = value;
              });
              Get.to(Home(), transition: Transition.cupertino);
            } else if (value == 2) {
              setState(() {
                current_page = value;
              });
              Get.to(Home(), transition: Transition.cupertino);
            } else if (value == 3) {
              setState(() {
                current_page = value;
              });
              Get.to(Home(), transition: Transition.cupertino);
            }
          },
          destinations: [
            NavigationDestination(
              icon: Icon(
                Icons.home,
                color: current_page == 0 ? Colors.white : primaryColor,
              ),
              label: 'Home',
            ),
            NavigationDestination(
                icon: Icon(
                  Icons.person,
                  color: current_page == 1 ? Colors.white : primaryColor,
                ),
                label: 'Expenses'),
            NavigationDestination(
                icon: Icon(
                  Icons.add_box_outlined,
                  color: current_page == 2 ? Colors.white : primaryColor,
                ),
                label: 'Add'),
            NavigationDestination(
                icon: Icon(
                  Icons.savings_outlined,
                  color: current_page == 3 ? Colors.white : primaryColor,
                ),
                label: 'Set'),
          ],
        ),
      ),
    );
  }

  Widget Total_Card() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Monthly Spends',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\u{20B9}' + stats!.totalMonthlySpend.toString(),
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\u{20B9}' + stats!.monthlyBudget.toString(),
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: GFProgressBar(
                percentage: stats!.totalMonthlySpend == 0
                    ? 0
                    : (stats!.totalMonthlySpend! /
                                int.parse(stats!.monthlyBudget.toString())) >
                            1
                        ? 1
                        : (stats!.totalMonthlySpend! /
                            int.parse(stats!.monthlyBudget.toString())),
                progressBarColor: secondaryColor,
                backgroundColor: Colors.grey.shade400,
                lineHeight: 10,
              ),
            ),
            Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'All Time Spends',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\u{20B9}' + stats!.totalSpendAllTime.toString(),
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget Category_Card(
      {required String category_name,
      required int? spent_amount,
      required int? budget,
      required IconData icon}) {
    var color;
    if (budget == 0) {
      color = Colors.grey.shade400;
    } else {
      var percentage = (spent_amount! / int.parse(budget.toString()));
      if (percentage > 0.8) {
        color = Colors.red;
      } else if (percentage > 0.5) {
        color = Colors.amber;
      } else if (percentage == 0) {
        color = Colors.grey.shade200;
      } else {
        color = Colors.green;
      }
    }
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
                    icon,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  category_name,
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
                    '\u{20B9}' + spent_amount.toString(),
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '\u{20B9}' + budget.toString(),
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: GFProgressBar(
                percentage: spent_amount == 0
                    ? 0
                    : (spent_amount! / int.parse(budget.toString())) > 1
                        ? 1
                        : (spent_amount! / int.parse(budget.toString())),
                progressBarColor: color,
                backgroundColor: Colors.grey.shade200,
                lineHeight: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
