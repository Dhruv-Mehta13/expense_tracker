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
import 'package:lottie/lottie.dart';

int food_and_dining = 0;
int housing = 0;
int transportation = 0;
int healthcare = 0;
int entertainment = 0;
int personal_care = 0;
int utilities = 0;
int others = 0;
int total = 0;

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
      food_and_dining = stats.categoryBudgets!.foodDining!;
      housing = stats.categoryBudgets!.housing!;
      transportation = stats.categoryBudgets!.transportation!;
      healthcare = stats.categoryBudgets!.healthcare!;
      entertainment = stats.categoryBudgets!.entertainment!;
      personal_care = stats.categoryBudgets!.personalCare!;
      utilities = stats.categoryBudgets!.utilities!;
      others = stats.categoryBudgets!.others!;
      total = food_and_dining.toInt() +
          housing.toInt() +
          transportation.toInt() +
          healthcare.toInt() +
          entertainment.toInt() +
          personal_care.toInt() +
          utilities.toInt() +
          others.toInt();
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
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Row(
                  children: [
                    Text('Set Budget',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              // SetBudgetCard(
              //     category: 'Food & Dining',
              //     icon: Icons.restaurant,
              //     budgetValue: food_and_dining),
              // SetBudgetCard(
              //     category: 'Housing', icon: Icons.home, budgetValue: housing),
              // SetBudgetCard(
              //     category: 'Transportation',
              //     icon: Icons.train,
              //     budgetValue: transportation),
              // SetBudgetCard(
              //     category: 'Healthcare',
              //     icon: Icons.local_hospital,
              //     budgetValue: healthcare),
              // SetBudgetCard(
              //     category: 'Entertainment',
              //     icon: Icons.movie_outlined,
              //     budgetValue: entertainment),
              // SetBudgetCard(
              //     category: 'Personal Care',
              //     icon: Icons.bathtub_outlined,
              //     budgetValue: personal_care),
              // SetBudgetCard(
              //     category: 'Utilities',
              //     icon: Icons.electrical_services,
              //     budgetValue: utilities),
              // SetBudgetCard(
              //     category: 'Others', icon: Icons.add, budgetValue: others),
              Container(
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
                              Icons.restaurant,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Food & Dining',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            '\u{20B9} ${food_and_dining}',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Slider(
                                value: food_and_dining.toDouble(),
                                min: 0,
                                max: 100000,
                                onChanged: (newValue) {
                                  setState(() {
                                    food_and_dining = newValue.toInt();
                                    total = food_and_dining.toInt() +
                                        housing.toInt() +
                                        transportation.toInt() +
                                        healthcare.toInt() +
                                        entertainment.toInt() +
                                        personal_care.toInt() +
                                        utilities.toInt() +
                                        others.toInt();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
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
                              Icons.home,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Housing',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            '\u{20B9} ${housing}',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Slider(
                                value: housing.toDouble(),
                                min: 0,
                                max: 10000,
                                onChanged: (newValue) {
                                  setState(() {
                                    housing = newValue.toInt();
                                    total = food_and_dining.toInt() +
                                        housing.toInt() +
                                        transportation.toInt() +
                                        healthcare.toInt() +
                                        entertainment.toInt() +
                                        personal_care.toInt() +
                                        utilities.toInt() +
                                        others.toInt();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
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
                              Icons.train,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Transportation',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            '\u{20B9} ${transportation}',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Slider(
                                value: transportation.toDouble(),
                                min: 0,
                                max: 10000,
                                onChanged: (newValue) {
                                  setState(() {
                                    transportation = newValue.toInt();
                                    total = food_and_dining.toInt() +
                                        housing.toInt() +
                                        transportation.toInt() +
                                        healthcare.toInt() +
                                        entertainment.toInt() +
                                        personal_care.toInt() +
                                        utilities.toInt() +
                                        others.toInt();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
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
                              Icons.local_hospital,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Healthcare',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            '\u{20B9} ${healthcare}',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Slider(
                                value: healthcare.toDouble(),
                                min: 0,
                                max: 10000,
                                onChanged: (newValue) {
                                  setState(() {
                                    healthcare = newValue.toInt();
                                    total = food_and_dining.toInt() +
                                        housing.toInt() +
                                        transportation.toInt() +
                                        healthcare.toInt() +
                                        entertainment.toInt() +
                                        personal_care.toInt() +
                                        utilities.toInt() +
                                        others.toInt();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
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
                              Icons.movie_outlined,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Entertainment',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            '\u{20B9} ${entertainment}',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Slider(
                                value: entertainment.toDouble(),
                                min: 0,
                                max: 10000,
                                onChanged: (newValue) {
                                  setState(() {
                                    entertainment = newValue.toInt();
                                    total = food_and_dining.toInt() +
                                        housing.toInt() +
                                        transportation.toInt() +
                                        healthcare.toInt() +
                                        entertainment.toInt() +
                                        personal_care.toInt() +
                                        utilities.toInt() +
                                        others.toInt();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
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
                              Icons.bathtub_outlined,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Personal Care',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            '\u{20B9} ${personal_care}',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Slider(
                                value: personal_care.toDouble(),
                                min: 0,
                                max: 10000,
                                onChanged: (newValue) {
                                  setState(() {
                                    personal_care = newValue.toInt();
                                    total = food_and_dining.toInt() +
                                        housing.toInt() +
                                        transportation.toInt() +
                                        healthcare.toInt() +
                                        entertainment.toInt() +
                                        personal_care.toInt() +
                                        utilities.toInt() +
                                        others.toInt();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
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
                              Icons.electrical_services,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Utilities',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            '\u{20B9} ${utilities}',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Slider(
                                value: utilities.toDouble(),
                                min: 0,
                                max: 10000,
                                onChanged: (newValue) {
                                  setState(() {
                                    utilities = newValue.toInt();
                                    total = food_and_dining.toInt() +
                                        housing.toInt() +
                                        transportation.toInt() +
                                        healthcare.toInt() +
                                        entertainment.toInt() +
                                        personal_care.toInt() +
                                        utilities.toInt() +
                                        others.toInt();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
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
                              Icons.add,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Others',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Text(
                            '\u{20B9} ${others}',
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Slider(
                                value: others.toDouble(),
                                min: 0,
                                max: 10000,
                                onChanged: (newValue) {
                                  setState(() {
                                    others = newValue.toInt();
                                    total = food_and_dining.toInt() +
                                        housing.toInt() +
                                        transportation.toInt() +
                                        healthcare.toInt() +
                                        entertainment.toInt() +
                                        personal_care.toInt() +
                                        utilities.toInt() +
                                        others.toInt();
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                child: Row(
                  children: [
                    Text('Total Monthly Budget: \u{20B9} $total',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),

              InkWell(
                onTap: () {
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
                        child: Center(
                          child: LottieBuilder.asset('assets/svg/loading.json'),
                        ),
                      ),
                    ],
                  ));
                  var categoryBudgets = {
                    "Food & Dining": int.parse(food_and_dining.toString()),
                    "Housing": int.parse(housing.toString()),
                    "Transportation": int.parse(transportation.toString()),
                    "Healthcare": int.parse(healthcare.toString()),
                    "Entertainment": int.parse(entertainment.toString()),
                    "Utilities": int.parse(utilities.toString()),
                    "Personal Care": int.parse(personal_care.toString()),
                    "Others": int.parse(others.toString()),
                  };
                  UserData.SetBudget(categoryBudgets, total).then((value) {
                    Get.back();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Expense Added Successfully'),
                      ),
                    );
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(top: 15, left: 15, right: 15),
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'Set Budget',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
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
            Get.off(SetBudget(), transition: Transition.cupertino);
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
  int budgetValue;

  SetBudgetCard(
      {Key? key,
      required this.category,
      required this.icon,
      required this.budgetValue})
      : super(key: key);

  @override
  _SetBudgetCardState createState() => _SetBudgetCardState();
}

class _SetBudgetCardState extends State<SetBudgetCard> {
  @override
  void initState() {
    super.initState();
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
                Spacer(),
                Text(
                  '\u{20B9} ${widget.budgetValue.toInt()}',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Slider(
                      value: widget.budgetValue.toDouble(),
                      min: 0,
                      max: 10000,
                      onChanged: (newValue) {
                        setState(() {
                          widget.budgetValue = newValue.toInt();
                          total = food_and_dining.toInt() +
                              housing.toInt() +
                              transportation.toInt() +
                              healthcare.toInt() +
                              entertainment.toInt() +
                              personal_care.toInt() +
                              utilities.toInt() +
                              others.toInt();
                        });
                      },
                    ),
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
