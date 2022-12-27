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

    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed('/');
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
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.2),
                          ),
                          borderRadius: BorderRadius.circular(10),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("images/notes logo.png"),
                          ),
                        ),
                      ),
                      const SizedBox(width: 7),
                      Text(
                        "Keep Notes",
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
