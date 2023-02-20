import 'package:flutter/material.dart';
import 'package:ticktok/const/colors.dart';
import 'package:ticktok/widgets/custom_add_icon.dart';

class HomePage extends StatefulWidget {
   const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIDX = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        onTap: (index) {
          setState(() {
            pageIDX = index;
          });
        },
        currentIndex: pageIDX,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 25,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                size: 25,
              ),
              label: "Search"),
          BottomNavigationBarItem(icon: CustomAddIcon(), label: ""),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.message,
                size: 25,
              ),
              label: "Messages"),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 25,
              ),
              label: "Profile"),
        ],
      ),
      body: Center(
        child: pageIndex[pageIDX],
      ),
    );
  }
}
