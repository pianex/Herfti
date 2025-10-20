import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_a/firebase_options.dart';
import 'package:project_a/view/pages/auth/user_type_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'خدماتي',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const UserTypePage(),
    );
  }
}
