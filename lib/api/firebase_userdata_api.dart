import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseUserDataAPI {
  //instantiate an instance of Cloud Firestore
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  //fetch the data
  // Stream<QuerySnapshot> getAllEntries() {
  //   return db.collection("userdata").snapshots();
  // }

  //   //add slambook entry to database
  // Future<String> addSlambookEntry(Map<String, dynamic> entry) async {
  //   try {
  //     await db.collection("slambookentry").add(entry);
  //     return "Successfully added slambook entry!";
  //   } on FirebaseException catch (e) {
  //     // return Exception("Failed with error '${e.code}: ${e.message}");
  //     throw Exception("Failed with error '${e.code}: ${e.message}");
  //   }
  // }

  Future<String> addUserData(Map<String, dynamic> userData) async {
    try{
      await db.collection("userdata").add(userData);
      return "Successfully added user!";
    } on FirebaseException catch (e) {
      throw Exception("Failed with error '${e.code}: ${e.message}");
    }
  }
}