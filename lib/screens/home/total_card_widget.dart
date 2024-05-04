import 'package:expense_tracker/constants/colors.dart';
import 'package:expense_tracker/models/Stats.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';

Widget Total_Card(Stats stats) {
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
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
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
