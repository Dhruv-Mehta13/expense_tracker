import 'package:expense_tracker/constants/colors.dart';
import 'package:expense_tracker/models/Stats.dart';
import 'package:expense_tracker/screens/home/category_card_widget.dart';
import 'package:expense_tracker/screens/home/total_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/data/UserData.dart';
import 'package:expense_tracker/models/User.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:get/route_manager.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shimmer/shimmer.dart';

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
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: isDataLoaded
            ? Expanded(
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
              )
            : Expanded(
                child: Row(
                  children: [
                    Row(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade400,
                          child: CircleAvatar(
                            radius: 20,
                            backgroundColor: primaryColor,
                            child: Text(
                              "XX",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                        child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade400,
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey.shade300,
                        ),
                      ),
                    )),
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
            Total_Card(stats!),
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
                    Shimmer_Category_Card(),
                    Shimmer_Category_Card(),
                    Shimmer_Category_Card(),
                    Shimmer_Category_Card(),
                    Shimmer_Category_Card(),
                    Shimmer_Category_Card(),
                    Shimmer_Category_Card(),
                    Shimmer_Category_Card(),
                  ]),
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
}
