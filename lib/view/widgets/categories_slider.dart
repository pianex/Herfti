import 'package:flutter/material.dart';
import 'package:project_a/core/functions/shuffled_categories.dart';

class CategoriesSlider extends StatelessWidget {
  const CategoriesSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
      width: MediaQuery.of(context).size.width,
      height: 140,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(width: 10),
          ...shuffledCategories(),
          const SizedBox(width: 10),
        ]..shuffle,
      ),
    );
  }
}
