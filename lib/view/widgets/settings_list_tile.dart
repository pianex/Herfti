// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_a/view/pages/auth/user_type_page.dart';

class SettingsListTile extends StatelessWidget {
  const SettingsListTile({
    super.key,
    required this.label,
    required this.iconData,
    required this.routeName,
    required this.route,
    this.logout,
  });
  final String label;
  final IconData iconData;
  final String routeName;
  final bool? logout;
  final Widget route;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      padding: const EdgeInsets.all(10),
      // height: 60,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF202652),
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: () {
          if (logout == true) {
            showDialog(
              context: context,
              builder: (context) => Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialog(
                  content: const Text(
                    "هل تريد حقا تسجيل الخروج؟",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "إلغاء",
                        style: TextStyle(
                          color: Colors.brown,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onDoubleTap: () {},
                      onTap: () async {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserTypePage(),
                          ),
                          (context) => false,
                        );
                      },
                      child: const Text(
                        "تسجيل الخروج",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            // Navigator.pushNamed(context, routeName);
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => route),
            );

            // Navigator.of(context).pop();
          }
        },
        child: Row(
          children: [
            Icon(
              iconData,
              color: logout == null || logout == false
                  ? Colors.white
                  : Colors.red,
              size: 22,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: logout == null || logout == false
                      ? Colors.white
                      : Colors.red,
                  fontSize: 22,
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
