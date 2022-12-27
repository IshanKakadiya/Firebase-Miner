import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/screens/addNotes_page.dart';
import 'package:notes_app/screens/home_page.dart';
import 'package:notes_app/screens/spalshScreen_page.dart';

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
        "AddNotes_Page": (context) => const AddNotes_Page(),
        "SpalshScreen_Page": (context) => const SpalshScreen_Page(),
      },
    ),
  );
}
