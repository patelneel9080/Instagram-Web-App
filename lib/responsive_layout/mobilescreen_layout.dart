import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

import '../screens/home_screen.dart';
import '../screens/post_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/reel_screen.dart';
import '../screens/search_screen.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  String userName = "";
  int selectedIndex = 0;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    getData();
    pageController = PageController(initialPage: selectedIndex);
  }

  void getData() async {
    DocumentSnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (snap.exists) {
      // Check if the document exists
      Map<String, dynamic>? data = snap.data() as Map<String, dynamic>?;

      if (data != null && data.containsKey("userName")) {
        setState(() {
          userName = data["userName"];
        });
        log(userName);
      } else {
        log("userName field is missing in the document");
      }
    } else {
      log("Document does not exist");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: <Widget>[
          HomeScreen(),
          Container(
            alignment: Alignment.center,
            child: Icon(
              Icons.favorite_rounded,
              size: 56,
              color: Colors.red[400],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Icon(
              Icons.email_rounded,
              size: 56,
              color: Colors.green[400],
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Icon(
              Icons.folder_rounded,
              size: 56,
              color: Colors.blue[400],
            ),
          ),
          // Container(
          //   alignment: Alignment.center,
          //   child: Icon(
          //     Icons.folder_rounded,
          //     size: 56,
          //     color: Colors.blue[400],
          //   ),
          // ),
        ],
      ),
      bottomNavigationBar: WaterDropNavBar(
        bottomPadding: 12,
        barItems: [
          BarItem(
            filledIcon: Icons.home,
            outlinedIcon: Icons.home_outlined,
          ),
          BarItem(
              filledIcon: Icons.search,
              outlinedIcon: Icons.search_outlined),
          BarItem(
            filledIcon: Icons.add_box,
            outlinedIcon: Icons.add_box_outlined,
          ),
          // BarItem(
          //   filledIcon: Icons.favorite,
          //   outlinedIcon: Icons.favorite_outline,
          // ),
          BarItem(filledIcon: Icons.account_circle, outlinedIcon: Icons.account_circle_outlined)
        ],
        selectedIndex: selectedIndex,
        onItemSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
          pageController.animateToPage(selectedIndex,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuad);
        },
      ),
    );
  }
}
