import 'package:flutter/material.dart';
import 'package:project_a/view/pages/about_page.dart';
import 'package:project_a/view/pages/professionals_page.dart';
import 'package:project_a/view/widgets/settings_list_tile.dart';
import 'package:project_a/view/widgets/title_text.dart';

class CustDrawer extends StatelessWidget {
  const CustDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: Color(0xFF11152E),
      width: size.width * 0.77,
      child: SafeArea(
        child: Column(
          // physics: const BouncingScrollPhysics(),
          children: [
            TitleText(title: "حرفتي"),
            SettingsListTile(
              label: "الوظائف",
              iconData: Icons.work,
              routeName: "",
              route: ProfessionalsPage(),
            ),
            SettingsListTile(
              label: "أفضل الحرفيين",
              iconData: Icons.attractions_sharp,
              routeName: "",
              route: ProfessionalsPage(),
            ),
            // SettingsListTile(
            //   label: "التصنيفات",
            //   iconData: Icons.list,
            //   routeName: "",
            //   route: ProfessionalsPage(),
            // ),
            SettingsListTile(
              label: "من نحن",
              iconData: Icons.info,
              routeName: "",
              route: AboutPage(),
            ),
            SettingsListTile(
              label: "تسجيل الخروج",
              iconData: Icons.logout_outlined,
              logout: true,
              routeName: "",
              route: ProfessionalsPage(),
            ),
          ],
        ),
      ),
    );
  }
}
