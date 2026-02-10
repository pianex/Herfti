import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/core/functions/date_functions.dart';
import 'package:project_a/core/functions/post_functions.dart';
import 'package:project_a/main.dart';
import 'package:project_a/view/pages/prof_account_page.dart';
import 'package:project_a/view/pages/new_post_page.dart';
import 'package:project_a/view/widgets/cust_drawer.dart';
import 'package:project_a/view/widgets/post_card.dart';
import 'package:project_a/view/widgets/title_text.dart';

class ProfHomePage extends StatefulWidget {
  const ProfHomePage({super.key});

  @override
  State<ProfHomePage> createState() => _ProfHomePageState();
}

class _ProfHomePageState extends State<ProfHomePage> {
  @override
  Widget build(BuildContext context) {
    String? imagePath = sharedPref.getString("imagePath");
    String googleImagePath = sharedPref.getString("googleImagePath")!;
    // print(googleImagePath);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: backgroundColor,
        drawer: CustDrawer(),

        appBar: AppBar(
          backgroundColor: appBarColor,
          leading: Builder(
            builder:
                (context) => // Ensure Scaffold is in context
                MaterialButton(
                  child: Icon(Icons.menu, color: Colors.white),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
          ),
          title: Text(
            "حرفتي",
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
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfAccountPage()),
                );
              },
              child: Container(
                margin: EdgeInsets.all(8),
                height: 40,
                width: 40,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.blue[700],
                  shape: BoxShape.circle,
                ),

                child: Image.network(
                  imagePath ?? googleImagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.person, color: Colors.white, size: 25);
                  },
                ),
                // Icon(Icons.person, color: Colors.white),
              ),
            ),
          ],
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            // Align(
            //   alignment: AlignmentGeometry.center,
            //   child: TitleText(title: "استكشف التصنيفات"),
            // ),
            // CategoriesSlider(),
            TitleText(title: "آخر المنشورات"),
            StreamBuilder(
              stream: readPosts(null),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('حدث خطأ ما! ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final posts = snapshot.data!;
                  // List<String> profsNames = [];
                  // List<String> profsTypes = [];
                  // List<String> profsImagePaths = [];

                  for (var post in posts) {
                    // if (profsNames.length == posts.length) break;
                    FirebaseFirestore.instance
                        .collection("Profs")
                        .doc(post.profUid)
                        .get()
                        .then((doc) {
                          // profsNames.add(doc.data()!["name"]);
                          // profsTypes.add(doc.data()!["category"]);
                          // profsImagePaths.add(doc.data()!["imagePath"]);
                          // print(profsNames);
                          FirebaseFirestore.instance
                              .collection("Posts")
                              .doc(post.uid)
                              .update({
                                "profName": doc.data()!["name"],
                                "profType": doc.data()!["category"],
                                "profImagePath": doc.data()!["imagePath"],
                              });
                        });
                  }

                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return PostCard(
                        uid: snapshot.data![index].uid,
                        profUid: snapshot.data![index].profUid,
                        name: snapshot.data![index].profName,
                        type: snapshot.data![index].profType,
                        profImagePath: snapshot.data![index].profImagePath,
                        time: timeAddedFormatted(
                          snapshot.data![index].timeAdded,
                        ),
                        imagePath: snapshot.data![index].imagePaths.isNotEmpty
                            ? snapshot.data![index].imagePaths[0].toString()
                            : "",
                        text: snapshot.data![index].text,
                        likes: snapshot.data![index].likesCount,
                        comments: snapshot.data![index].commentsCount,
                        firstTag: snapshot.data![index].profImagePath,
                        secondTag: snapshot.data![index].imagePaths.isNotEmpty
                            ? snapshot.data![index].imagePaths[0].toString()
                            : "",
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => NewPostPage()),
            );
          },
          child: Icon(Icons.post_add, size: 30),
        ),
      ),
    );
  }
}
