import 'package:flutter/material.dart';
import 'package:ielts_cat/gen/assets.gen.dart';

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
          icon: Assets.icons.bottomAppBar.listening.image(
            width: 30,
            height: 30,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          label: 'Listening',
        ),
        BottomNavigationBarItem(
          icon: Assets.icons.bottomAppBar.reading.image(
            width: 30,
            height: 30,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          label: 'Reading',
        ),
        BottomNavigationBarItem(
          icon: Assets.icons.bottomAppBar.writing.image(
            width: 30,
            height: 30,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          label: 'Writing',
        ),
        BottomNavigationBarItem(
          icon: Assets.icons.bottomAppBar.speaking.image(
            width: 30,
            height: 30,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          label: 'Speaking',
        ),
        BottomNavigationBarItem(
          icon: Assets.icons.bottomAppBar.calculator.image(
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
