import 'package:flutter/material.dart';
import 'package:project_a/main.dart';

class IdCategoryCard extends StatelessWidget {
  const IdCategoryCard({
    super.key,
    required this.category,
    required this.image,
    required this.sellerType,
  });
  final String category;
  final String image;
  final int sellerType;

  @override
  Widget build(BuildContext context) {
    final userType = sharedPref.getString('userType');
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10),
      width: 130,
      height: 80,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: GestureDetector(
        onTap: () {
          if (userType == 'seller') {
            sharedPref.setInt("sellerType", sellerType);
            sharedPref.setString("currentStep", "userInfoPage");
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (context) => const UserInfoPage()),
            //   (route) => false,
            // );
          } else {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => SellersListPage(
            //       appBarTitle: category,
            //       sellerType: sellerType,
            //       backImage: image,
            //     ),
            //   ),
            // );
          }
        },
        child: Stack(
          children: [
            Container(
              width: 130,
              height: 80,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(image, fit: BoxFit.cover),
            ),
            Container(
              width: 130,
              height: 80,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: AlignmentGeometry.topCenter,
                  end: AlignmentGeometry.bottomCenter,
                  colors: [
                    Colors.black.withAlpha(200),
                    Colors.black.withAlpha(120),
                    Colors.black.withAlpha(0),
                  ],
                ),
                borderRadius: BorderRadius.circular(15),
              ),
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
          ],
        ),
      ),
    );
  }
}
