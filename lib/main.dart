import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_with_firebase/Screens/SpalshScreen_Page.dart';
import 'package:login_with_firebase/Screens/home_page.dart';
import 'package:login_with_firebase/Screens/login_page.dart';
import 'package:login_with_firebase/Screens/ragister_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "SpalshScreen_Page",
      routes: {
        "Login_Page": (context) => const Login_Page(),
        "Ragister_Page": (context) => const Ragister_Page(),
        "/": (context) => const Home_Page(),
        "SpalshScreen_Page": (context) => const SpalshScreen_Page(),
      },
    ),
  );
}
