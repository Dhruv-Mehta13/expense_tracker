import 'package:expense_tracker/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:shimmer/shimmer.dart';

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

Widget Shimmer_Category_Card() {
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
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade400,
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(
                    Icons.abc,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade400,
                child: Container(
                  margin: EdgeInsets.only(left: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.grey.shade300,
                  ),
                  width: 100,
                  height: 25,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade400,
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.shade300,
                    ),
                    width: 80,
                    height: 20,
                  ),
                ),
                Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade400,
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.grey.shade300,
                    ),
                    width: 80,
                    height: 20,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade400,
              child: GFProgressBar(
                percentage: 0,
                progressBarColor: Colors.grey.shade400,
                backgroundColor: Colors.grey.shade200,
                lineHeight: 10,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
