// ignore_for_file: camel_case_types, sort_child_properties_last, non_constant_identifier_names, use_build_context_synchronously, unused_local_variable

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:author_registration_app/helper/author_helper.dart';
import 'package:author_registration_app/screens/Globle.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBooks_Page extends StatefulWidget {
  const AddBooks_Page({super.key});

  @override
  State<AddBooks_Page> createState() => _AddBooks_PageState();
}

class _AddBooks_PageState extends State<AddBooks_Page> {
  GlobalKey<FormState> authorKey = GlobalKey<FormState>();

  TextEditingController authorController = TextEditingController();
  TextEditingController booksController = TextEditingController();

  final ImagePicker image = ImagePicker();
  String? imagePicked;
  Uint8List? dataImage;

  @override
  void initState() {
    super.initState();
    if (Globle.editBooks) {
      authorController.text = Globle.updateBookData[0]["authorName"];
      booksController.text = Globle.updateBookData[0]["bookName"];

      if (Globle.updateBookData[0]["photo"] != null) {
        dataImage = base64Decode(Globle.updateBookData[0]["photo"]);
        imagePicked = base64Encode(dataImage!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: (Globle.editBooks)
            ? const Text("Book Update")
            : const Text("Add Books"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: authorKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                (Globle.editBooks)
                    ? (Globle.imageFile == null && Globle.photosFile == null)
                        ? CircleAvatar(
                            maxRadius: 70,
                            backgroundColor: Colors.grey[400],
                            backgroundImage:
                                (Globle.updateBookData[0]["photo"] != null &&
                                        dataImage != null)
                                    ? MemoryImage(dataImage!)
                                    : null,
                            child: (Globle.updateBookData[0]["photo"] == null ||
                                    dataImage == null)
                                ? const Text(
                                    "ADD BOOK IMAGE",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 23,
                                    ),
                                  )
                                : null,
                          )
                        : CircleAvatar(
                            maxRadius: 70,
                            backgroundColor: Colors.grey[400],
                            backgroundImage: (Globle.cameraPhoto)
                                ? (Globle.imageFile != null)
                                    ? FileImage(Globle.imageFile!)
                                    : null
                                : (Globle.photosFile != null)
                                    ? FileImage(Globle.photosFile!)
                                    : null,
                            child: (Globle.cameraPhoto)
                                ? (Globle.imageFile == null)
                                    ? const Text(
                                        "ADD BOOK IMAGE",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 23,
                                        ),
                                      )
                                    : null
                                : (Globle.photosFile == null)
                                    ? const Text(
                                        "ADD BOOK IMAGE",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 25,
                                        ),
                                      )
                                    : null,
                          )
                    : CircleAvatar(
                        maxRadius: 70,
                        backgroundColor: Colors.grey[400],
                        backgroundImage: (Globle.cameraPhoto)
                            ? (Globle.imageFile != null)
                                ? FileImage(Globle.imageFile!)
                                : null
                            : (Globle.photosFile != null)
                                ? FileImage(Globle.photosFile!)
                                : null,
                        child: (Globle.cameraPhoto)
                            ? (Globle.imageFile == null)
                                ? const Text(
                                    "ADD BOOK IMAGE",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 23,
                                    ),
                                  )
                                : null
                            : (Globle.photosFile == null)
                                ? const Text(
                                    "ADD BOOK IMAGE",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 25,
                                    ),
                                  )
                                : null,
                      ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) => AlertDialog(
                            title: const Center(
                              child: Text("Select Ones"),
                            ),
                            actionsAlignment: MainAxisAlignment.spaceAround,
                            actions: [
                              Column(
                                children: [
                                  ElevatedButton(
                                    child: const Icon(
                                      Icons.camera,
                                    ),
                                    onPressed: () async {
                                      Globle.cameraPhoto = false;

                                      XFile? Gallery = await image.pickImage(
                                        source: ImageSource.camera,
                                        imageQuality: 10,
                                      );

                                      Globle.photosFile = File(Gallery!.path);
                                      Uint8List imagebytes = await Globle
                                          .photosFile!
                                          .readAsBytes();
                                      imagePicked = base64Encode(imagebytes);

                                      setState(() {});
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  const SizedBox(height: 2),
                                  const Text(
                                    "Camera",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                    child: const Icon(
                                      Icons.photo_library_sharp,
                                    ),
                                    onPressed: () async {
                                      Globle.cameraPhoto = true;
                                      XFile? Photo = await image.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 1,
                                      );

                                      Globle.imageFile = File(Photo!.path);
                                      Uint8List imagebytes =
                                          await Globle.imageFile!.readAsBytes();
                                      imagePicked = base64Encode(imagebytes);

                                      setState(() {});
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  const SizedBox(height: 2),
                                  const Text(
                                    "Gallery",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        child: const Icon(
                          Icons.add,
                          size: 30,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        Globle.photosFile = null;
                        Globle.imageFile = null;
                        imagePicked = null;
                        dataImage = null;

                        setState(() {});
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 30,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: authorController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter Author Name";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Author Name",
                    border: OutlineInputBorder(),
                    labelText: "Author Name",
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: booksController,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter Book Name";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: "Book Name",
                    border: OutlineInputBorder(),
                    labelText: "Book Name",
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    (Globle.editBooks) ? "BOOK UPDATE" : "BOOK ADD",
                    style: const TextStyle(
                      color: Colors.teal,
                    ),
                  ),
                  onPressed: () async {
                    if (Globle.editBooks) {
                      if (authorKey.currentState!.validate()) {
                        await Author_Helper.author_helper.updateData(
                          id: Globle.updateBookData[0].id,
                          authorName: authorController.text,
                          bookName: booksController.text,
                          photo: imagePicked,
                        );
                      }
                    } else {
                      if (authorKey.currentState!.validate()) {
                        await Author_Helper.author_helper.insertData(
                          authorName: authorController.text,
                          bookName: booksController.text,
                          photo: imagePicked,
                        );
                      }
                    }
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
