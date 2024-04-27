// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';    
import '../models/userdata_model.dart';
import '../api/firebase_userdata_api.dart';

class userDataProvider with ChangeNotifier{
  late FirebaseUserDataAPI firebaseService;

  userDataProvider() : firebaseService = FirebaseUserDataAPI();
  // late Stream<QuerySnapshot> _userDataStream;

  //list of entries
  final List<userData> _entries = [];

  //getter
  List<userData> get entry => _entries;

  //add to firebase 
  Future<void> addItem(userData user) async {
    String message = await firebaseService.addUserData(user.toJson());
    print(message);
    notifyListeners();
  }
} 
