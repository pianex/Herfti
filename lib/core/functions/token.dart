import 'package:firebase_messaging/firebase_messaging.dart';

String myToken = '';
Future<String> getToken() async {
  final result = await FirebaseMessaging.instance.getToken();

  return result!;
}
