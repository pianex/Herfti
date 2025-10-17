import 'package:flutter/material.dart';
import 'package:project_a/core/functions/formatters.dart';
import 'package:project_a/view/pages/prof_profile.dart';

class ProfessionalCard extends StatelessWidget {
  const ProfessionalCard({
    super.key,
    required this.category,
    required this.image,
    required this.sellerType,
    required this.name,
    required this.saves,
    required this.tag,
  });
  final String name;
  final String category;
  final String image;
  final int sellerType;
  final int saves;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfessionalProfile(tag: tag),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: 100,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Color(0xFF151E2B),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              // margin: const EdgeInsets.all(10),
              width: 80,
              height: 80,

              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(image, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  Text(
                    category,
                    style: TextStyle(color: Colors.white, fontSize: 21),
                  ),
                ],
              ),
            ),
            Spacer(),
            Text(
              shrinkLikesFormula(saves),
              style: TextStyle(
                color: Colors.purple,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.bookmark, color: Colors.purple, size: 30),
          ],
        ),
      ),
    );
  }
}
