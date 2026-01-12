import 'package:flutter/material.dart';
import 'package:ielts_cat/gen/assets.gen.dart';

class LoadingIndicator extends StatelessWidget {
  final double? size; // Optional custom size

  const LoadingIndicator({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: Assets.animations.catLoading.image(width: size ?? width / 3),
    );
  }
}
