import 'package:expense_tracker/constants/colors.dart';
import 'package:expense_tracker/data/UserData.dart';
import 'package:expense_tracker/models/User.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shimmer/shimmer.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isDataLoaded;
  final User? currentUser;
  final String userInitials;

  MyAppBar(
      {this.isDataLoaded = false,
      this.currentUser,
      this.userInitials = '',
      Key? key})
      : super(key: key);

  @override
  _AppBarState createState() => _AppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}

class _AppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      title: widget.isDataLoaded
          ? Expanded(
              child: Row(
                children: [
                  widget.currentUser != null
                      ? Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: primaryColor,
                              child: Text(
                                widget.userInitials,
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
                      'Welcome, ${widget.currentUser?.username}',
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
    );
  }
}
