import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double? size; // Optional custom size

  const LoadingIndicator({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: Image.asset(
        "assets/animations/cat_loading.gif",
        width: size ?? width / 3,
      ),
    );
  }
}
