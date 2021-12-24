import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:yourfuel/models/user.dart' as userApp;

class FireBase {
  final _fireAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<bool> checkExitsPhone(String phone) async {
    var isExits = false;
    await _usersCollection
        .doc(phone)
        .get()
        .then((value) => isExits = value.exists);

    return isExits;
  }

  Future registerUser(
      {required String phone,
      required Function(PhoneAuthCredential) verificationCompleted,
      required Function(FirebaseAuthException) verificationFailed,
      required Function(String, int?) codeSent,
      required Function(String?) codeAutoRetrievalTimeout}) async {
    _fireAuth.setLanguageCode("vn");
    _fireAuth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  Future<void> addUser(userApp.User user) async {
    await _usersCollection.doc(user.phone).set(user.toJson());
  }

  Future<UserCredential> signInWithCredential(
      String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    return await _fireAuth.signInWithCredential(credential);
  }

  Future<String> checkPass({required String phone})async{
    final passString= await _usersCollection.doc(phone).get();
    return passString["pass"];
  }

  Future<userApp.User> getUserData({required String phone})async{
    final userJson= await _usersCollection.doc(phone).get();
    return userApp.User.fromJson(userJson.data());
  }
//
// Future<user.User> getCurrentUser() async {
//   if(_fireAuth.currentUser != null){
//     final userData = await _usersCollection.doc(_fireAuth.currentUser?.uid).get();
//     if(userData != null){
//       final _user = user.User.fromJson(userData.data());
//       return _user;
//     }
//     else{
//       return null;
//     }
//   }
//   else{
//     return null;
//   }
// }

}
