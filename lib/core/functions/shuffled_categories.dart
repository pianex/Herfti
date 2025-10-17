import 'package:flutter/material.dart';
import 'package:project_a/view/widgets/category_card.dart';

List shuffledCategories() {
  final result = [
    CategoryCard(
      category: "كهربائي",
      image: "assets/images/Electrician.jpeg",
      sellerType: 1,
      iconData: Icons.electrical_services_rounded,
      isGrid: false,
    ),
    CategoryCard(
      category: "خبير التبريد",
      image: "assets/images/frigouriste.jpeg",
      sellerType: 2,
      iconData: Icons.snowing,
      isGrid: false,
    ),
    CategoryCard(
      category: "بناء",
      image: "assets/images/macon.png",
      sellerType: 3,
      iconData: Icons.house,
      isGrid: false,
    ),
    CategoryCard(
      category: "ميكانيكي",
      image: "assets/images/mechanic.jpg",
      sellerType: 4,
      iconData: Icons.car_repair_rounded,
      isGrid: false,
    ),
    CategoryCard(
      category: "طلاء",
      image: "assets/images/painter.jpg",
      sellerType: 5,
      iconData: Icons.format_paint_rounded,
      isGrid: false,
    ),
    CategoryCard(
      category: "سباك",
      image: "assets/images/plumber.jpg",
      sellerType: 6,
      iconData: Icons.water_drop_rounded,
      isGrid: false,
    ),
    CategoryCard(
      category: "تلحيم",
      image: "assets/images/soudeur.jpeg",
      sellerType: 7,
      iconData: Icons.fireplace_outlined,
      isGrid: false,
    ),
    CategoryCard(
      category: "نجار",
      image: "assets/images/najjar.jpg",
      sellerType: 7,
      iconData: Icons.door_sliding_sharp,
      isGrid: false,
    ),
    CategoryCard(
      category: "خياط",
      image: "assets/images/knitting.jpeg",
      sellerType: 7,
      isGrid: false,

      iconData: Icons.approval_sharp,
    ),
  ];
  result.shuffle();
  return result;
}
