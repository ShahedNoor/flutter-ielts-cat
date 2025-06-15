import 'package:flutter/material.dart';

class MyBottomAppBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const MyBottomAppBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/bottom_app_bar/listening.png",
            width: 30,
            height: 30,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          label: 'Listening',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/bottom_app_bar/reading.png",
            width: 30,
            height: 30,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          label: 'Reading',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/bottom_app_bar/writing.png",
            width: 30,
            height: 30,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          label: 'Writing',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/bottom_app_bar/speaking.png",
            width: 30,
            height: 30,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          label: 'Speaking',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            "assets/icons/bottom_app_bar/calculator.png",
            width: 30,
            height: 30,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          label: 'Calculator',
        ),
      ],
    );
  }
}
