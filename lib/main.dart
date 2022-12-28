import 'package:author_registration_app/screens/SpalshScreen_page.dart';
import 'package:author_registration_app/screens/addBooks_Page.dart';
import 'package:author_registration_app/screens/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: "SpalshScreen_Page",
      routes: {
        "/": (context) => const Home_Page(),
        "AddBooks_Page": (context) => const AddBooks_Page(),
        "SpalshScreen_Page": (context) => const SpalshScreen_Page(),
      },
    ),
  );
}
