import 'package:flutter/material.dart';

class SquareLoginTile extends StatelessWidget {
  final String image;
  final void Function()? onTap;

  const SquareLoginTile({super.key, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Center(
          child: Image.asset(image),
        ),
      ),
    );
  }
}
