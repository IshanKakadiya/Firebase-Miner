// ignore_for_file: camel_case_types, unused_local_variable, no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';
import 'package:login_with_firebase/helper/login_helper.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({super.key});

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  TextStyle fontStyle = GoogleFonts.openSans(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  GlobalKey<FormState> loginFromKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String? email;
  String? password;

  bool passwordVisibal = false;

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      "Images/Login_Page/logo2.PNG",
                      height: 40,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "PNFT Market",
                      style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Text(
                "NFT Access",
                style: GoogleFonts.openSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "please fill your details to access your account",
                style: GoogleFonts.openSans(
                  fontSize: 13,
                ),
              ),
              Form(
                key: loginFromKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      "Email",
                      style: GoogleFonts.openSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: emailController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Email Address";
                        }

                        return null;
                      },
                      onSaved: (val) {
                        email = emailController.text;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 1,
                        ),
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.email),
                        filled: true,
                        hintText: "Email",
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "Password",
                      style: GoogleFonts.openSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: passwordController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Passowrd";
                        }

                        return null;
                      },
                      onSaved: (val) {
                        password = passwordController.text;
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: (passwordVisibal) ? false : true,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: (passwordVisibal)
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              passwordVisibal = !passwordVisibal;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          gapPadding: 1,
                        ),
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.lock_open),
                        filled: true,
                        hintText: "Password",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forget Your Password ? ",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              fontSize: 13,
                              color: Colors.indigoAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () async {
                        if (loginFromKey.currentState!.validate()) {
                          loginFromKey.currentState!.save();

                          try {
                            User? user = await RagisterHelper.ragisterHelper
                                .signIn(email: email!, password: password!);

                            if (user != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Sign-In Sucessfully..."),
                                  backgroundColor: Colors.green,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );

                              Navigator.of(context).pushReplacementNamed("/");
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Sign-In Failed..."),
                                  backgroundColor: Colors.red,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          } on FirebaseAuthException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.message!),
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          }
                        }
                      },
                      child: Container(
                        height: 45,
                        // width: _width * 0.44,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Login",
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () async {
                        User? user = await RagisterHelper.ragisterHelper
                            .signWithGoogle();

                        if (user != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Login Sucessfully..."),
                              backgroundColor: Colors.green,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );

                          Navigator.of(context).pushReplacementNamed("/");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Login Failed..."),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 45,
                        width: _width,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "Images/Login_Page/GoogleLogo.png",
                              height: 30,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "Login with Gmail",
                              style: GoogleFonts.openSans(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have a account? ",
                          style: fontStyle.copyWith(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 14,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacementNamed("Ragister_Page");
                          },
                          child: Text(
                            "Sign in",
                            style: GoogleFonts.openSans(
                              color: Colors.indigoAccent,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 70),
                    const Divider(
                      height: 30,
                      color: Colors.indigoAccent,
                      thickness: 3,
                      indent: 100,
                      endIndent: 100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
