import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:yourfuel/models/checkout_data.dart';
import 'package:yourfuel/models/fuel_price.dart';
import 'package:yourfuel/models/fuel_station.dart';
import 'package:yourfuel/models/user.dart' as userApp;

class FireBase {
  final _fireAuth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _stationsUserCollection =
      FirebaseFirestore.instance.collection('station_user');
  final CollectionReference _stationsDefaultCollection =
      FirebaseFirestore.instance.collection('station_default');
  final CollectionReference _priceListCollection =
      FirebaseFirestore.instance.collection('price_list');
  final CollectionReference _checkoutCollection =
      FirebaseFirestore.instance.collection('checkout');

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

  Future<String> checkPass({required String phone}) async {
    final passString = await _usersCollection.doc(phone).get();
    return passString["pass"];
  }

  Future<userApp.User> getUserData({required String phone}) async {
    final userJson = await _usersCollection.doc(phone).get();
    return userApp.User.fromJson(userJson.data());
  }

  Future<List<FuelStation>> getStationsUser() async {
    final dataList =
        await _stationsUserCollection.doc(userApp.User.instance.phone).get();
    if (dataList.exists) {
      List<FuelStation> list = List<FuelStation>.from(
          dataList["listStation"].map((e) => FuelStation.fromJson(e))).toList();
      return list;
    }
    return [];
  }

  Future<List<FuelPrice>> getPriceList() async {
    final dataList =
        await _priceListCollection.doc(userApp.User.instance.phone).get();
    if (dataList.exists) {
      List<FuelPrice> list = List<FuelPrice>.from(
          dataList["priceList"].map((e) => FuelPrice.fromJson(e))).toList();
      return list;
    }
    return [];
  }

  Future<List<FuelStation>> getStationsDefault() async {
    final dataList = await _stationsDefaultCollection.doc("station").get();
    List<FuelStation> list = List<FuelStation>.from(
        dataList["listStation"].map((e) => FuelStation.fromJson(e))).toList();
    return list;
  }

  Future<void> updateStationUser(
      List<FuelStation> stationList, bool isSetHasBeen) async {
    var json = stationList.map((e) => e.toJson()).toList();
    await _stationsUserCollection
        .doc(userApp.User.instance.phone)
        .set({"listStation": json});

    if (isSetHasBeen) {
      await _usersCollection
          .doc(userApp.User.instance.phone)
          .update({"hasBeenSet": true});
    }
  }

  Future<void> updateStationDefault(List<FuelStation> stationList) async {
    var json = stationList.map((e) => e.toJson()).toList();
    await _stationsDefaultCollection.doc("station").set({"listStation": json});
  }

  Future<void> updateFuelPrices(List<FuelPrice> list) async {
    var json = list.map((e) => e.toJson()).toList();
    await _priceListCollection
        .doc(userApp.User.instance.phone)
        .set({"priceList": json});
  }

  Future<void> addCheckoutData(CheckOutData data) async {
    await _checkoutCollection
        .doc(userApp.User.instance.phone)
        .set({"pla": data.toJson()});
  }

  Future<int> getNumberCheckoutByDate() async {
    // final data =
    //     await _checkoutCollection.doc(userApp.User.instance.phone).;
    // List<FuelStation> list = List<FuelStation>.from(
    //     dataList["listStation"].map((e) => FuelStation.fromJson(e))).toList();
    return 0;
  }
}
