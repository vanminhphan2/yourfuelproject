import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FireBase{
  final _fireAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');

  Future registerUser(String mobile, BuildContext context, Function(PhoneAuthCredential) verificationCompleted,
      Function(FirebaseAuthException) verificationFailed, Function(String, int?) codeSent, Function(String?) codeAutoRetrievalTimeout) async{

    _fireAuth.verifyPhoneNumber(
        phoneNumber: mobile,
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout
    );
  }

  // Future<void> verifyPhoneNumber(
  //     {required String phoneNumber,
  //       required Function(FirebaseAuthException) verificationFailed,
  //       required Function(String, int) codeSent,
  //       required Function(String) codeAutoRetrievalTimeout}) async {
  //
  //   await _fireAuth.verifyPhoneNumber(
  //     phoneNumber: phoneNumber,
  //     verificationCompleted: (_) => null,
  //     verificationFailed: verificationFailed,
  //     codeSent: null,
  //     codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
  //   );
  // }
  //
  // Future<void> signInWithCredential(String verificationId, String smsCode) async {
  //   PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //       verificationId: verificationId, smsCode: smsCode);
  //   await _fireAuth.signInWithCredential(credential);
  // }
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