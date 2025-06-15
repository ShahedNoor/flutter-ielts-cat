import 'package:flutter/material.dart';

class MyBottomAppBar extends StatefulWidget {
  const MyBottomAppBar({super.key});

  @override
  State<MyBottomAppBar> createState() => _MyBottomAppBarState();
}

class _MyBottomAppBarState extends State<MyBottomAppBar> {
  int currentPage = 0; // Default index for the bottom navigation bar

  // Toggle between pages
  void togglePages(int pageCount) {
    setState(() {
      currentPage = pageCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentPage,
      onTap: togglePages,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/bottom_app_bar/listening.png",
            width: 30,
            height: 30,
          ),
          label: 'Listening',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/bottom_app_bar/reading.png",
            width: 30,
            height: 30,
          ),
          label: 'Reading',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/bottom_app_bar/writing.png",
            width: 30,
            height: 30,
          ),
          label: 'Writing',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/bottom_app_bar/speaking.png",
            width: 30,
            height: 30,
          ),
          label: 'Speaking',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/bottom_app_bar/calculator.png",
            width: 30,
            height: 30,
          ),
          label: 'Calculator',
        ),
      ],
    );
  }
}
