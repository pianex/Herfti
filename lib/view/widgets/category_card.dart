import 'package:flutter/material.dart';
import 'package:project_a/view/pages/category_page.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.image,
    required this.sellerType,
    required this.iconData,
    required this.isGrid,
  });
  final String category;
  final String image;
  final int sellerType;
  final IconData iconData;
  final bool isGrid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CategoryPage()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10, left: 10),
        width: isGrid ? double.infinity : 140,
        height: isGrid ? 140 : 120,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Container(
              width: isGrid ? double.infinity : 140,
              height: isGrid ? 140 : 120,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(image, fit: BoxFit.cover),
            ),
            Container(
              width: isGrid ? double.infinity : 140,
              height: isGrid ? 140 : 120,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                  colors: [
                    Colors.black.withAlpha(0),
                    Colors.black.withAlpha(100),
                    Colors.black.withAlpha(200),
                  ],
                ),
                // color: Colors.black.withAlpha(80),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    width: double.infinity,
                    height: 35,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Color(0xFF151E2B),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: Align(
                      alignment: AlignmentGeometry.center,
                      child: Text(
                        category,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(7),
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(iconData, color: Colors.white, size: 20),
            ),
          ],
        ),
      ),
    );
  }
}
