import 'package:flutter/material.dart';
import 'package:project_a/core/functions/shuffled_categories.dart';

class CategoriesGrid extends StatelessWidget {
  const CategoriesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 0,
        mainAxisExtent: 150,
      ),
      children: [...shuffledCategories()],
    );
  }
}
