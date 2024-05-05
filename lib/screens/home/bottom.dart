import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:expense_tracker/constants/colors.dart';

class Bottom_Navigation_Bar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const Bottom_Navigation_Bar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: MaterialStateProperty.resolveWith<TextStyle>(
          (Set<MaterialState> states) => states.contains(MaterialState.selected)
              ? const TextStyle(color: Colors.black, fontSize: 15)
              : const TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
      child: NavigationBar(
        backgroundColor: Colors.white,
        selectedIndex: currentIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        indicatorColor: primaryColor,
        onDestinationSelected: onTap,
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.home,
              color: currentIndex == 0 ? Colors.white : primaryColor,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person,
              color: currentIndex == 1 ? Colors.white : primaryColor,
            ),
            label: 'Expenses',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.add_box_outlined,
              color: currentIndex == 2 ? Colors.white : primaryColor,
            ),
            label: 'Add',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.savings_outlined,
              color: currentIndex == 3 ? Colors.white : primaryColor,
            ),
            label: 'Set',
          ),
        ],
      ),
    );
  }
}
