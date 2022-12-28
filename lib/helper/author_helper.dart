// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class Author_Helper {
  Author_Helper._();
  static final Author_Helper author_helper = Author_Helper._();

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Insert Data
  Future<DocumentReference<Map<String, dynamic>>> insertData({
    required String authorName,
    required String bookName,
    required String? photo,
  }) async {
    Map<String, dynamic> data = {
      "authorName": authorName,
      "bookName": bookName,
      "photo": photo,
    };
    DocumentReference<Map<String, dynamic>> docRef =
        await firestore.collection("books").add(data);

    return docRef;
  }

  // Fetch Data
  Stream<QuerySnapshot> fetchAllData() {
    return firestore.collection("books").snapshots();
  }

  // Delete Data
  Future<void> deleteData({required String id}) async {
    await firestore.collection("books").doc(id).delete();
  }

  // Update Data
  Future<void> updateData({
    required String id,
    required String authorName,
    required String bookName,
    required String? photo,
  }) async {
    //
    Map<String, dynamic> data = {
      "authorName": authorName,
      "bookName": bookName,
      "photo": photo,
    };

    await firestore.collection("books").doc(id).update(data);
  }
}
