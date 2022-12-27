// ignore_for_file: camel_case_types, unused_local_variable, use_build_context_synchronously, no_leading_underscores_for_local_identifiers, unused_field, prefer_final_fields

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes_app/Globle.dart';
import 'package:notes_app/helper/AddNotes_Helper.dart';

class AddNotes_Page extends StatefulWidget {
  const AddNotes_Page({super.key});

  @override
  State<AddNotes_Page> createState() => _AddNotes_PageState();
}

TextEditingController titleController = TextEditingController();
TextEditingController noteController = TextEditingController();

class _AddNotes_PageState extends State<AddNotes_Page> {
  GlobalKey<FormState> insertKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (Globle.updaeNote) {
      noteController.text = Globle.updateData[0]["note"];
      titleController.text = Globle.updateData[0]["title"];
    }
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    dynamic res = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: (Globle.updaeNote)
            ? const Text("ADD UPDATE")
            : const Text("ADD ADD"),
        actions: [
          (Globle.updaeNote)
              ? IconButton(
                  icon: const Icon(
                    Icons.delete,
                  ),
                  onPressed: () async {
                    await AddNotesHelper.addNotesHelper
                        .deleteData(id: Globle.updateData[0].id);
                    titleController.clear();
                    noteController.clear();
                    Globle.updaeNote = false;
                    Navigator.of(context).pop();
                  },
                )
              : Container(),
          const SizedBox(width: 10),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 5, right: 5, top: 10),
        height: _height,
        width: _width,
        child: Column(
          children: [
            Form(
              key: insertKey,
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: "Title",
                      ),
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      controller: noteController,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Note";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        hintText: "Note",
                      ),
                    ),
                    const SizedBox(height: 20),
                    (Globle.updaeNote)
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: const Text(
                              "NOTE UPDATE",
                              style: TextStyle(
                                color: Colors.teal,
                              ),
                            ),
                            onPressed: () async {
                              if (insertKey.currentState!.validate()) {
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

                                await AddNotesHelper.addNotesHelper.updateData(
                                  date: date,
                                  title: titleController.text,
                                  id: Globle.updateData[0].id,
                                  note: noteController.text,
                                  time: time,
                                );

                                Globle.updaeNote = false;
                                Navigator.of(context).pop();
                              }
                            },
                          )
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: const Text(
                              "ADD NOTE",
                              style: TextStyle(
                                color: Colors.teal,
                              ),
                            ),
                            onPressed: () async {
                              if (insertKey.currentState!.validate()) {
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

                                await AddNotesHelper.addNotesHelper.insertData(
                                  date: date,
                                  title: titleController.text,
                                  note: noteController.text,
                                  time: time,
                                );

                                titleController.clear();
                                noteController.clear();
                                Globle.updaeNote = false;
                                Navigator.of(context).pop();
                              }
                            },
                          ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(10),
              height: 40,
              color: Colors.white.withOpacity(0.2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (Globle.updaeNote)
                        ? (res["date"] == Globle.updateData[0]["date"])
                            ? "Edited ${Globle.updateData[0]["time"]}"
                            : "Edited ${Globle.updateData[0]["date"]}"
                        : "Edited ${res["time"]}",
                    style: GoogleFonts.openSans(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
