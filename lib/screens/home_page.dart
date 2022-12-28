// ignore_for_file: camel_case_types, unused_local_variable, use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';
import 'package:author_registration_app/helper/author_helper.dart';
import 'package:author_registration_app/screens/Globle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";
import 'package:google_fonts/google_fonts.dart';

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
        title: const Text("Author Registration"),
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
          Globle.editBooks = false;
          Globle.imageFile = null;
          Globle.photosFile = null;
          Navigator.of(context).pushNamed("AddBooks_Page");
        },
      ),
      body: StreamBuilder(
        stream: Author_Helper.author_helper.fetchAllData(),
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
                Map data = {
                  "photo": allDoc[i]["photo"],
                  "authorName": allDoc[i]["authorName"],
                  "bookName": allDoc[i]["bookName"],
                };

                if (data["photo"] != null) {
                  Uint8List decodeImage = base64Decode(allDoc[i]["photo"]);
                  data["photo"] = decodeImage;
                }

                return Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.5),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white),
                          image: (data["photo"] != null)
                              ? DecorationImage(
                                  fit: BoxFit.cover,
                                  image: MemoryImage(data["photo"]),
                                )
                              : null,
                        ),
                        alignment: Alignment.center,
                        child: (data["photo"] == null)
                            ? Text(
                                "Image Not Uploaded",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.openSans(),
                              )
                            : null,
                      ),
                      const SizedBox(width: 15),
                      SizedBox(
                        width: 183,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data["authorName"],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.openSans(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              data["bookName"],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: GoogleFonts.openSans(
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Globle.editBooks = true;
                                    Globle.imageFile = null;
                                    Globle.photosFile = null;
                                    Globle.updateBookData.clear();
                                    Globle.updateBookData.add(allDoc[i]);

                                    Navigator.of(context)
                                        .pushNamed("AddBooks_Page");
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      color: Colors.teal,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.edit,
                                      size: 18,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 15),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text(
                                                "Are You Sure Delete ? "),
                                            actions: [
                                              OutlinedButton(
                                                child: const Text("Cancle"),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                              ElevatedButton(
                                                child: const Text("Delete"),
                                                onPressed: () async {
                                                  Navigator.of(context).pop();
                                                  await Author_Helper
                                                      .author_helper
                                                      .deleteData(
                                                    id: allDoc[i].id,
                                                  );
                                                },
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.delete,
                                      size: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
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
