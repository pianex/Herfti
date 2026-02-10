import 'package:flutter/material.dart';
import 'package:project_a/core/constants/app_theme.dart';
import 'package:project_a/core/functions/prof_functions.dart';
import 'package:project_a/view/widgets/prof_card.dart';

class ProfessionalsPage extends StatelessWidget {
  const ProfessionalsPage({super.key});

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
            "حرفيون",
            style: TextStyle(
              color: appBarTextColor,
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: readProfs(null),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("حدث خطأ ما");
            } else if (snapshot.hasData) {
              final profs = snapshot.data!;
              return ListView.builder(
                itemCount: profs.docs.length,
                itemBuilder: (context, index) {
                  final prof = profs.docs[index];
                  return ProfessionalCard(
                    uid: prof["uid"],
                    name: prof["name"],
                    imagePath: prof["imagePath"],
                    phone: prof["phone"],
                    email: prof["uid"],
                    description: prof["description"],
                    type: prof["type"],
                    category: prof["category"],
                    country: prof["country"],
                    state: prof["state"],
                    city: prof["city"],
                    saves: prof["saves"],
                    timeAdded: prof["timeAdded"],
                    tokens: List<String>.from(prof["tokens"] ?? []),
                    image: prof["imagePath"],
                    sellerType: prof["type"],
                    tag: "",
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }
          },
        ),
      ),
    );
  }
}
