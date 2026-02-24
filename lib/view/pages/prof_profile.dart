import 'dart:ui';

import 'package:awesome_icons/awesome_icons.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:like_button/like_button.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/core/functions/date_functions.dart';
import 'package:project_a/core/functions/formatters.dart';
import 'package:project_a/core/functions/post_functions.dart';
import 'package:project_a/core/functions/prof_functions.dart';
import 'package:project_a/main.dart';
import 'package:project_a/view/widgets/contact_button.dart';
import 'package:project_a/view/widgets/post_card.dart';
import 'package:project_a/view/widgets/title_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfessionalProfile extends StatelessWidget {
  const ProfessionalProfile({
    super.key,
    required this.tag,
    required this.profUid,
  });
  final String tag;
  final String profUid;

  @override
  Widget build(BuildContext context) {
    Image asset = Image.network(tag, fit: BoxFit.cover);
    String email = sharedPref.getString("email")!;

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
            "صفحة الحرفي",
            style: TextStyle(
              color: appBarTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          centerTitle: true,
          actions: [
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.message, color: Colors.white),
            // ),
            IconButton(
              onPressed: () {
                final prof = FirebaseFirestore.instance
                    .collection("Profs")
                    .doc(profUid);
                prof.get().then((doc) async {
                  final Uri launchUri = Uri(
                    scheme: 'tel',
                    path: doc.data()!["phone"],
                  );
                  await launchUrl(launchUri);
                });
              },
              icon: Icon(Icons.phone, color: Colors.white),
            ),
            // IconButton(
            //   onPressed: () {},
            //   icon: Icon(Icons.location_on, color: Colors.white),
            // ),
          ],
        ),
        body: FutureBuilder(
          future: readProf(profUid),
          builder: (context, asyncSnapshot) {
            if (asyncSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (asyncSnapshot.hasError) {
              return Center(child: Text("حدث خطأ ما"));
            } else if (asyncSnapshot.data!.exists) {
              final data = asyncSnapshot.data!;
              return ListView(
                children: [
                  Hero(
                    tag: tag,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Dialog(
                              shadowColor: Colors.black,
                              child: Container(
                                width: double.infinity,
                                height: asset.height,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    color: Colors.white,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                    width: 5,
                                  ),
                                ),
                                child: Image.network(tag, fit: BoxFit.cover),
                              ),
                            ).animate().untint(),
                          ),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        clipBehavior: Clip.hardEdge,
                        height: MediaQuery.of(context).size.width / 2,
                        width: MediaQuery.of(context).size.width / 2,
                        decoration: BoxDecoration(
                          color: appBarColor,
                          // borderRadius: BorderRadius.circular(15),
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(tag, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      TitleText(title: data["name"] ?? ""),
                      Text(
                        data["category"],
                        style: TextStyle(color: Colors.white, fontSize: 23),
                      ),
                      LikeButton(
                        countPostion: CountPostion.left,
                        likeCountPadding: EdgeInsets.symmetric(horizontal: 10),
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        countDecoration: (counter, likeCount) {
                          return Text(
                            shrinkLikesFormula(data["saves"]),
                            style: TextStyle(
                              color: const Color.fromARGB(255, 182, 67, 202),
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                        // isLiked: widget.isLiked,
                        likeCount: data["saves"] ?? 0,
                        likeBuilder: (isLiked) {
                          return Icon(
                            isLiked ? Icons.bookmark : Icons.bookmark_border,
                            color: const Color.fromARGB(255, 182, 67, 202),
                            size: 40,
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ContactButton(
                        label: "واتساب",
                        icon: FontAwesomeIcons.whatsapp,
                        onTap: () {
                          final Uri launchUri = Uri(
                            scheme: 'https',
                            host: 'wa.me',
                            path: data["whatsapp"],
                          );
                          launchUrl(
                            launchUri,
                            mode: LaunchMode.externalApplication,
                          );
                        },
                      ),

                      ContactButton(
                        label: "فيسبوك",
                        icon: FontAwesomeIcons.facebook,
                        onTap: () {
                          launchUrl(
                            Uri.parse(data["facebook"] ?? ""),
                            mode: LaunchMode.externalApplication,
                          );
                        },
                      ),
                    ],
                  ),
                  TitleText(title: "الخدمات"),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: Text(
                      data["description"],
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10),
                  TitleText(title: "المنشورات"),
                  StreamBuilder(
                    stream: readPosts(profUid),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text('حدث خطأ ما! ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        if (snapshot.data!.isEmpty) {
                          return Text(
                            "لا يوجد منشورات حتى الآن.",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          );
                        } else {
                          final posts = snapshot.data!;
                          for (var post in posts) {
                            FirebaseFirestore.instance
                                .collection("Profs")
                                .doc(post.userUid)
                                .get()
                                .then((doc) {
                                  FirebaseFirestore.instance
                                      .collection("Posts")
                                      .doc(post.uid)
                                      .update({
                                        "profName": doc.data()!["name"],
                                        "profType": doc.data()!["category"],
                                        "profImagePath": doc
                                            .data()!["imagePath"],
                                      });
                                });
                          }
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: posts.length,
                            itemBuilder: (context, index) {
                              bool isLiked = snapshot.data![index].likersUids
                                  .contains(email);
                              return PostCard(
                                uid: snapshot.data![index].uid,
                                userUid: snapshot.data![index].userUid,
                                name: snapshot.data![index].userName,
                                type: snapshot.data![index].profType,
                                userImagePath:
                                    snapshot.data![index].userImagePath,
                                time: timeAddedFormatted(
                                  snapshot.data![index].timeAdded,
                                ),
                                imagePath:
                                    snapshot.data![index].imagePaths.isNotEmpty
                                    ? snapshot.data![index].imagePaths[0]
                                          .toString()
                                    : "",
                                imagePaths:
                                    snapshot.data![index].imagePaths.isNotEmpty
                                    ? snapshot.data![index].imagePaths
                                    : [],
                                text: snapshot.data![index].text,
                                likes: snapshot.data![index].likesCount,
                                isLiked: isLiked,
                                comments: snapshot.data![index].commentsCount,
                                likersUids: snapshot.data![index].likersUids,
                                firstTag: snapshot.data![index].userImagePath,
                                secondTag:
                                    snapshot.data![index].imagePaths.isNotEmpty
                                    ? snapshot.data![index].imagePaths[0]
                                          .toString()
                                    : "",
                              );
                            },
                          );
                        }
                      } else {
                        return Center(
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  "هذا الحساب غير موجود.",
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
