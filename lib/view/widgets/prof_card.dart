import 'package:flutter/material.dart';
import 'package:project_a/core/functions/formatters.dart';
import 'package:project_a/view/pages/prof_profile.dart';

class ProfessionalCard extends StatelessWidget {
  const ProfessionalCard({
    super.key,
    required this.uid,
    required this.name,
    required this.imagePath,
    required this.phone,
    required this.email,
    required this.description,
    required this.type,
    required this.category,
    required this.country,
    required this.state,
    required this.city,
    required this.saves,
    required this.timeAdded,
    required this.tokens,
    required this.image,
    required this.sellerType,
    required this.tag,
  });
  final String uid;
  final String name;
  final String imagePath;
  final String phone;
  final String email;
  final String description;
  final int type;
  final String category;
  final String country;
  final String state;
  final String city;
  final int saves;
  final String timeAdded;
  final List<String> tokens;
  final String image;
  final int sellerType;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfessionalProfile(tag: tag, profUid: uid),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        width: double.infinity,
        // height: 100,
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

              // height: 80,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(image, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Container(
                constraints: BoxConstraints(maxWidth: 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,

                      style: TextStyle(color: Colors.white, fontSize: 25),
                      overflow: TextOverflow.clip,
                    ),
                    Text(
                      category,
                      style: TextStyle(color: Colors.white, fontSize: 21),
                    ),
                  ],
                ),
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
