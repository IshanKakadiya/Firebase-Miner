// ignore_for_file: camel_case_types, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/Globle.dart';
import 'package:notes_app/helper/AddNotes_Helper.dart';
import 'package:notes_app/screens/addNotes_page.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({super.key});

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Keep Notes"),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Globle.updaeNote = false;
          titleController.clear();
          noteController.clear();
          DateTime dateTime = DateTime.now();

          String hours;
          String ampm;

          if (dateTime.hour >= 12) {
            ampm = "pm";
            int hour;
            if (dateTime.hour == 12) {
              hour = 12;
            } else {
              hour = dateTime.hour - 12;
            }
            hours = hour.toString();
          } else {
            hours = dateTime.hour.toString();
            ampm = "am";
          }

          String time = "$hours:${dateTime.minute} $ampm";

          String date = "${dateTime.day}/${dateTime.month}/${dateTime.year}";

          Map data = {
            "time": time,
            "date": date,
          };

          print("-----------------");
          print(data);
          print("-----------------");

          Navigator.of(context).pushNamed("AddNotes_Page", arguments: data);
        },
      ),
      body: StreamBuilder(
        stream: AddNotesHelper.addNotesHelper.fetchAllData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("ERROR : ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot? querySnapshot = snapshot.data;

            List<QueryDocumentSnapshot> allDoc = querySnapshot!.docs;

            return ListView.separated(
              padding: const EdgeInsets.all(15),
              itemCount: allDoc.length,
              separatorBuilder: (context, i) => const SizedBox(height: 10),
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    DateTime dateTime = DateTime.now();

                    String hours;
                    String ampm;

                    if (dateTime.hour >= 12) {
                      ampm = "pm";
                      int hour;
                      if (dateTime.hour == 12) {
                        hour = 12;
                      } else {
                        hour = dateTime.hour - 12;
                      }
                      hours = hour.toString();
                    } else {
                      hours = dateTime.hour.toString();
                      ampm = "am";
                    }

                    String time = "$hours:${dateTime.minute} $ampm";

                    String date =
                        "${dateTime.day}/${dateTime.month}/${dateTime.year}";

                    Map data = {
                      "time": time,
                      "date": date,
                    };
                    Globle.updateData.clear();
                    Globle.updaeNote = true;
                    Globle.updateData.add(allDoc[i]);
                    Navigator.of(context)
                        .pushNamed("AddNotes_Page", arguments: data);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          allDoc[i]["title"],
                          style: GoogleFonts.openSans(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          allDoc[i]["note"],
                          style: GoogleFonts.openSans(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
