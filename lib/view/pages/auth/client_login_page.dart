import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/core/functions/google_functions.dart';
import 'package:project_a/core/functions/token.dart';
import 'package:project_a/main.dart';
import 'package:project_a/view/pages/auth/client_info_page.dart';
import 'package:project_a/view/pages/client_home_page.dart';
import 'package:project_a/view/widgets/cust_progress_indicator.dart';
import 'package:project_a/view/widgets/title_text.dart';

class ClientLoginPage extends StatefulWidget {
  const ClientLoginPage({super.key});

  @override
  State<ClientLoginPage> createState() => _ClientLoginPageState();
}

class _ClientLoginPageState extends State<ClientLoginPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: appBarColor,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
          title: Text(
            "تسجيل الدخول",
            style: TextStyle(
              color: appBarTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image.asset("assets/images/step.jpg", fit: BoxFit.cover),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(color: Colors.black.withAlpha(180)),
            ),
            isLoading
                ? CustProgressIndicator()
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TitleText(title: "قم بتسجيل الدخول"),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 5,
                          ),
                          child: Divider(thickness: 2),
                        ),
                        TitleText(title: "سجل باستخدام Google"),
                        GestureDetector(
                          onTap: () async {
                            setState(() {
                              isLoading = true;
                            });
                            signInWithGoogle(
                              context: context,
                              onSuccess: () {
                                setState(() {
                                  isLoading = false;
                                });
                                String email = sharedPref.getString('email')!;
                                Future<DocumentSnapshot<Map<String, dynamic>>>
                                doc = FirebaseFirestore.instance
                                    .collection("Clients")
                                    .doc(email)
                                    .get();
                                doc.then((doc) async {
                                  if (doc.exists) {
                                    List<String> tokens = List<String>.from(
                                      doc.data()!["tokens"] ?? [],
                                    );
                                    String token = await getToken();

                                    if (!token.contains(token)) {
                                      tokens.add(token);
                                    }

                                    FirebaseFirestore.instance
                                        .collection("Clients")
                                        .doc(email)
                                        .update({"tokens": tokens});
                                    sharedPref.setString("userType", "client");
                                    sharedPref.setString(
                                      "uid",
                                      doc.data()!["uid"],
                                    );
                                    sharedPref.setString(
                                      "name",
                                      doc.data()!["name"],
                                    );
                                    sharedPref.setString(
                                      "desc",
                                      doc.data()!["description"],
                                    );
                                    sharedPref.setString(
                                      "phone",
                                      doc.data()!["phone"],
                                    );
                                    sharedPref.setString(
                                      "imagePath",
                                      doc.data()!["imagePath"],
                                    );
                                    sharedPref.setString(
                                      "state",
                                      doc.data()!["state"],
                                    );
                                    sharedPref.setString(
                                      "city",
                                      doc.data()!["city"],
                                    );
                                    sharedPref.setString(
                                      "country",
                                      doc.data()!["country"],
                                    );
                                    sharedPref.setStringList(
                                      "savedProfs",
                                      List<String>.from(
                                        doc.data()!["savedProfs"] ?? [],
                                      ),
                                    );
                                    sharedPref.setStringList(
                                      "likedPosts",
                                      List<String>.from(
                                        doc.data()!["likedPosts"] ?? [],
                                      ),
                                    );
                                    sharedPref.setStringList("tokens", tokens);

                                    Navigator.pushAndRemoveUntil(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      CupertinoPageRoute(
                                        builder: (context) => ClientHomePage(),
                                      ),
                                      (route) => false,
                                    );
                                  } else {
                                    Navigator.push(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ClientInfoPage(),
                                      ),
                                    );
                                  }
                                });
                              },
                              onFail: () {
                                setState(() {
                                  isLoading = false;
                                });
                              },
                            );
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                'assets/images/google_png.png',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
