// ignore_for_file: file_names, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';

class AddNotesHelper {
  AddNotesHelper._();
  static final AddNotesHelper addNotesHelper = AddNotesHelper._();

  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Insert Data
  Future<DocumentReference<Map<String, dynamic>>> insertData(
      {required String title,
      required String note,
      required String time,
      required String date}) async {
    Map<String, dynamic> data = {
      "title": title,
      "note": note,
      "time": time,
      "date": date,
    };
    DocumentReference<Map<String, dynamic>> docRef =
        await firestore.collection("notes").add(data);

    return docRef;
  }

  // Fetch Data
  Stream<QuerySnapshot> fetchAllData() {
    return firestore.collection("notes").snapshots();
  }

  // Delete Data
  Future<void> deleteData({required String id}) async {
    await firestore.collection("notes").doc(id).delete();
  }

  // Update Data
  Future<void> updateData(
      {required String title,
      required String id,
      required String note,
      required String time,
      required String date}) async {
    //
    Map<String, dynamic> data = {
      "title": title,
      "note": note,
      "time": time,
      "date": date,
    };

    await firestore.collection("notes").doc(id).update(data);
  }
}
