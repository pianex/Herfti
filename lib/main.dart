import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_a/firebase_options.dart';
import 'package:project_a/view/pages/auth/user_type_page.dart';
import 'package:project_a/view/pages/prof_home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String? userType = sharedPref.getString("userType");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'خدماتي',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: userType == "prof" ? ProfHomePage() : const UserTypePage(),
    );
  }
}
