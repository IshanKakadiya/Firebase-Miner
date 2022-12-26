// ignore_for_file: camel_case_types, no_leading_underscores_for_local_identifiers

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SpalshScreen_Page extends StatefulWidget {
  const SpalshScreen_Page({super.key});

  @override
  State<SpalshScreen_Page> createState() => _SpalshScreen_PageState();
}

class _SpalshScreen_PageState extends State<SpalshScreen_Page> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacementNamed('Login_Page');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TweenAnimationBuilder(
              tween: Tween<double>(begin: 1, end: 1.5),
              duration: const Duration(milliseconds: 5000),
              builder: (context, double _scale, _) {
                return Transform.scale(
                  scale: _scale,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage("Images/Login_Page/logo2.PNG"),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "PNFT Market",
                        style: GoogleFonts.openSans(
                          fontSize: 25,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
