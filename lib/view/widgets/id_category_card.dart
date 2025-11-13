import 'package:flutter/material.dart';
import 'package:project_a/view/pages/account_page.dart';
import 'package:project_a/view/pages/auth/prof_info_page.dart';

class IdCategoryCard extends StatefulWidget {
  const IdCategoryCard({
    super.key,
    required this.category,
    required this.image,
    required this.sellerType,
    this.isAccPage = false,
    this.onTap,
  });
  final String category;
  final String image;
  final int sellerType;
  final Function? onTap;
  final bool? isAccPage;

  @override
  State<IdCategoryCard> createState() => _IdCategoryCardState();
}

class _IdCategoryCardState extends State<IdCategoryCard> {
  @override
  Widget build(BuildContext context) {
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
          if (widget.onTap != null) {
            widget.onTap!();
          }
          if (widget.isAccPage!) {
            setState(() {
              accSelectedCategory = widget.sellerType;
              accSselectedCategoryString = widget.category;
            });
          } else {
            setState(() {
              selectedCategory = widget.sellerType;
              selectedCategoryString = widget.category;
            });
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
              child: Image.asset(widget.image, fit: BoxFit.cover),
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
                widget.category,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            selectedCategory == widget.sellerType
                ? Container(
                    padding: EdgeInsets.all(5),
                    width: 130,
                    height: 80,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(width: 5, color: Colors.green),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: selectedCategory == widget.sellerType
                        ? Align(
                            alignment: AlignmentGeometry.bottomCenter,
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.green,
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 27,
                                fontWeight: FontWeight.bold,
                                weight: 20,
                              ),
                            ),
                          )
                        : SizedBox(),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
