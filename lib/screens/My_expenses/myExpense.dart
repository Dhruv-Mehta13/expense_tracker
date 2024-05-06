import 'package:expense_tracker/constants/colors.dart';
import 'package:expense_tracker/data/UserData.dart';
import 'package:expense_tracker/models/Expense.dart';
import 'package:expense_tracker/models/Stats.dart';
import 'package:expense_tracker/models/User.dart';
import 'package:expense_tracker/screens/add_expense.dart/add.dart';
import 'package:expense_tracker/screens/home/app_bar.dart';
import 'package:expense_tracker/screens/home/bottom.dart';
import 'package:expense_tracker/screens/home/home.dart';
import 'package:expense_tracker/screens/set_budget/set_budget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

String _getInitials(String? username) {
  if (username != null) {
    if (username == 'Food & Dining') {
      return 'FD';
    }
    List<String> nameParts = username.split(' ');
    if (nameParts.length > 1) {
      return '${nameParts[0][0]}${nameParts[1][0]}';
    } else {
      return '${nameParts[0][0]}';
    }
  }
  return '';
}

var category_icons = {
  "Food & Dining": Icons.restaurant,
  "Housing": Icons.home,
  "Transportation": Icons.train,
  "Healthcare": Icons.local_hospital,
  "Entertainment": Icons.movie_creation_outlined,
  "Utilities": Icons.bathtub_outlined,
  "Personal Care": Icons.electrical_services,
  "Others": Icons.add,
};

class MyExpense extends StatefulWidget {
  const MyExpense({super.key});

  @override
  State<MyExpense> createState() => _MyExpenseState();
}

class _MyExpenseState extends State<MyExpense> {
  TextEditingController searchController = TextEditingController();
  var selectedFilter = 'All';
  var current_page = 1;
  var currentDate = DateTime.now().toIso8601String();
  User? currentUser;
  late String userInitials = '';
  var isDataLoaded = false;

  List<String> previousMonthsDates = [];
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
    previousMonthsDates = getPreviousMonthsDates(6);
    print(previousMonthsDates);
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

  List<String> getPreviousMonthsDates(int numberOfMonths) {
    List<String> dates = [];
    DateTime currentDate = DateTime.now();
    dates.add(currentDate.toIso8601String());
    for (int i = 0; i < numberOfMonths; i++) {
      DateTime previousMonth =
          currentDate.subtract(Duration(days: 30 * (i + 1)));
      String isoString = previousMonth.toIso8601String();
      dates.add(isoString);
    }

    return dates;
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: Row(
              children: [
                Text(
                  'My Expenses',
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (var date in previousMonthsDates)
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentDate = date;
                          });
                        },
                        child: Chip(
                          backgroundColor: primaryColor,
                          label: Text(DateFormat('MMM yyyy')
                              .format(DateTime.parse(date))),
                          labelStyle: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextField(
                    controller: searchController,
                    onEditingComplete: () {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search expenses',
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: ListView.builder(
                        itemCount: category_icons.length,
                        itemBuilder: (context, index) {
                          final category = category_icons.keys.elementAt(index);
                          final icon = category_icons.values.elementAt(index);
                          return ListTile(
                            leading: Icon(icon),
                            title: Text(category),
                            onTap: () {
                              setState(() {
                                selectedFilter = category;
                              });
                              print('Selected filter: $category');
                              Get.back(); // Close the bottom sheet after selection
                            },
                          );
                        },
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  margin: const EdgeInsets.only(right: 15),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: primaryColor, // Use your primaryColor here
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.filter_alt_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: isDataLoaded
                  ? FutureBuilder(
                      future: UserData.loadExpenses(currentDate),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Shimmer_Expense_card();
                            },
                          );
                        } else {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('An error occurred'),
                            );
                          } else {
                            List<Expense> expenses =
                                snapshot.data as List<Expense>;
                            return ListView.builder(
                              itemBuilder: (context, index) {
                                if (selectedFilter != 'All') {
                                  if (expenses[index]
                                      .category
                                      .toString()
                                      .toLowerCase()
                                      .contains(selectedFilter.toLowerCase())) {
                                    return Expense_card(
                                      category:
                                          expenses[index].category.toString(),
                                      description: expenses[index]
                                          .description
                                          .toString(),
                                      amount: int.parse(
                                          expenses[index].amount.toString()),
                                      date: DateFormat('dd MMM yyyy').format(
                                        DateTime.parse(
                                            expenses[index].date.toString()),
                                      ),
                                      name: expenses[index].name.toString(),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                }
                                if (searchController.text.isNotEmpty) {
                                  if (expenses[index]
                                      .name
                                      .toString()
                                      .toLowerCase()
                                      .contains(searchController.text
                                          .toLowerCase())) {
                                    return Expense_card(
                                      category:
                                          expenses[index].category.toString(),
                                      description: expenses[index]
                                          .description
                                          .toString(),
                                      amount: int.parse(
                                          expenses[index].amount.toString()),
                                      date: DateFormat('dd MMM yyyy').format(
                                        DateTime.parse(
                                            expenses[index].date.toString()),
                                      ),
                                      name: expenses[index].name.toString(),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                }
                                return Expense_card(
                                  category: expenses[index].category.toString(),
                                  description:
                                      expenses[index].description.toString(),
                                  amount: int.parse(
                                      expenses[index].amount.toString()),
                                  date: DateFormat('dd MMM yyyy').format(
                                    DateTime.parse(
                                        expenses[index].date.toString()),
                                  ),
                                  name: expenses[index].name.toString(),
                                );
                              },
                              itemCount: expenses.length,
                            );
                          }
                        }
                      })
                  : ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Shimmer_Expense_card();
                      },
                    )),
        ],
      ),
      bottomNavigationBar: Bottom_Navigation_Bar(
        currentIndex: current_page,
        onTap: (int index) {
          setState(() {
            current_page = index;
          });
          if (index == 0) {
            Get.offAll(Home(), transition: Transition.noTransition);
          } else if (index == 1) {
            Get.offAll(MyExpense(), transition: Transition.noTransition);
          } else if (index == 2) {
            Get.offAll(AddExpense(), transition: Transition.noTransition);
          } else if (index == 3) {
            Get.offAll(SetBudget(), transition: Transition.noTransition);
          }
        },
      ),
    );
  }
}

Widget Expense_card(
    {required String category,
    required String description,
    required int amount,
    required String date,
    required String name}) {
  return Container(
    margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(color: Colors.grey.shade300, blurRadius: 5),
      ],
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: primaryColor,
          child: Icon(
            category_icons[category],
            color: Colors.white,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
              Row(
                children: [
                  Text(description,
                      style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Text(
                  '\u{20B9} $amount',
                  style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  date,
                  style: TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

Widget Shimmer_Expense_card() {
  return Container(
    margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(color: Colors.grey.shade300, blurRadius: 5),
      ],
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade400,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: primaryColor,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade400,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.shade300,
                    ),
                    height: 18,
                    width: 100,
                  )),
              SizedBox(
                height: 10,
              ),
              Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade400,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.shade300,
                    ),
                    height: 14,
                    width: 200,
                  )),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade400,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.shade300,
                  ),
                  height: 18,
                  width: 80,
                )),
            SizedBox(
              height: 10,
            ),
            Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade400,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.shade300,
                  ),
                  height: 10,
                  width: 60,
                )),
          ],
        ),
      ],
    ),
  );
}
