import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/core/functions/date_functions.dart';
import 'package:project_a/core/functions/post_functions.dart';
import 'package:project_a/main.dart';
import 'package:project_a/view/pages/client_account_page.dart';
import 'package:project_a/view/pages/new_post_page.dart';
import 'package:project_a/view/widgets/categories_slider.dart';
import 'package:project_a/view/widgets/cust_drawer.dart';
import 'package:project_a/view/widgets/post_card.dart';
import 'package:project_a/view/widgets/title_text.dart';

class ClientHomePage extends StatelessWidget {
  const ClientHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    String email = sharedPref.getString("email")!;
    String? imagePath = sharedPref.getString("imagePath");
    String googleImagePath = sharedPref.getString("googleImagePath")!;
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
            "Kivr",
            style: TextStyle(
              color: appBarTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ClientAccountPage()),
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
            Align(
              alignment: AlignmentGeometry.center,
              child: TitleText(title: "استكشف التصنيفات"),
            ),
            CategoriesSlider(),
            TitleText(title: "آخر المنشورات"),

            StreamBuilder(
              stream: readPosts(null),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('حدث خطأ ما! ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final posts = snapshot.data!;

                  if (posts.isEmpty) {
                    return Center(
                      child: Text(
                        "لا يوجد منشورات بعد",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    );
                  } else {
                    // for (var post in posts) {
                    //   if (post.profType != "زبون") {
                    //     FirebaseFirestore.instance
                    //         .collection("Profs")
                    //         .doc(post.userUid)
                    //         .get()
                    //         .then((doc) {
                    //           // profsNames.add(doc.data()!["name"]);
                    //           // profsTypes.add(doc.data()!["category"]);
                    //           // profsImagePaths.add(doc.data()!["imagePath"]);
                    //           // print(profsNames);
                    //           FirebaseFirestore.instance
                    //               .collection("Posts")
                    //               .doc(post.uid)
                    //               .update({
                    //                 "userName": doc.data()!["name"],
                    //                 "profType": doc.data()!["category"],
                    //                 "userImagePath": doc.data()!["imagePath"],
                    //               });
                    //         });
                    //   } else {
                    //     FirebaseFirestore.instance
                    //         .collection("Clients")
                    //         .doc(post.userUid)
                    //         .get()
                    //         .then((doc) {
                    //           // profsNames.add(doc.data()!["name"]);
                    //           // profsTypes.add(doc.data()!["category"]);
                    //           // profsImagePaths.add(doc.data()!["imagePath"]);
                    //           // print(profsNames);
                    //           FirebaseFirestore.instance
                    //               .collection("Posts")
                    //               .doc(post.uid)
                    //               .update({
                    //                 "userName": doc.data()!["name"],
                    //                 "userImagePath": doc.data()!["imagePath"],
                    //               });
                    //         });
                    //   }
                    // }

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
                          isProf: snapshot.data![index].isProf,
                          type: snapshot.data![index].profType,
                          userImagePath: snapshot.data![index].userImagePath,
                          time: timeAddedFormatted(
                            snapshot.data![index].timeAdded,
                          ),
                          imagePath: snapshot.data![index].imagePaths.isNotEmpty
                              ? snapshot.data![index].imagePaths[0].toString()
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
                          secondTag: snapshot.data![index].imagePaths.isNotEmpty
                              ? snapshot.data![index].imagePaths[0].toString()
                              : "",
                        );
                      },
                    );
                  }
                } else {
                  return Center(
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  );
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
