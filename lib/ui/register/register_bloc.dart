import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/src/subjects/publish_subject.dart';
import 'package:yourfuel/controller/app_controller.dart';
import 'package:yourfuel/models/user.dart' as userApp;
import 'package:yourfuel/service/firebase.dart';
import 'package:yourfuel/utils/app_utils.dart';

class RegisterBloc {
  String storedVerificationId = "";
  int? resendToken;
  userApp.User user = userApp.User();

  Future<void> getCodeClick(
      String phone, PublishSubject<bool> onCanInputCode) async {
    try {
      print("onTap get code: " + phone);

      appController.loading.show();

      var isHavePhone = await FireBase().checkExitsPhone(phone);

      if (isHavePhone) {
        appController.dialog
            .showDefaultDialog(title: "Thong bao!", message: "SDT da ton tai!");
      } else {
        this.user.phone = phone;
        await FireBase().registerUser(
            phone: phone.replaceFirst("0", "+84"),
            verificationCompleted: (credential) {
              print("rio111 => " + credential.smsCode.toString());
            },
            verificationFailed: (e) {
              print("rio222 => " + (e.message ?? "Loi he thong!"));
              appController.dialog
                  .showDefaultDialog(title: "Thong bao!", message: e.message);
            },
            codeSent: (verificationId, token) {
              print("rio verificationId: $verificationId");
              print("rio token: $token");

              storedVerificationId = verificationId;
              resendToken = token;
              onCanInputCode.add(true);
            },
            codeAutoRetrievalTimeout: (p0) {
              print("rio444 => " + (p0 ?? ""));
            });
      }
      appController.loading.hide();
    } catch (e) {
      appController.dialog
          .showDefaultDialog(title: "Thong bao!", message: e.toString());
      appController.loading.hide();
    }
  }

  void verifyClick(BuildContext context, String pass, String code) async {
    print("firebase code: $storedVerificationId   input code: $code");
    if (pass.length < 6) {
      appController.dialog.showDefaultDialog(
          title: "Thong bao!", message: "Password to short!");
      return;
    }
    if (storedVerificationId.isEmpty) {
      appController.dialog
          .showDefaultDialog(title: "Thong bao!", message: "Loi he thong 112!");
      return;
    }
    if (code.isEmpty || code.length < 6) {
      appController.dialog.showDefaultDialog(
          title: "Thong bao!", message: "Chua nhap dung code!");
      return;
    }

    user.pass= AppHelper.generateMd5(pass);

    appController.loading.show();
    await FireBase()
        .signInWithCredential(storedVerificationId, code)
        .whenComplete(() async {
      var createTime = DateTime.now().toLocal();
      print("firebase Complete createTime: $createTime");
      await FireBase()
          .addUser(userApp.User(
              createDate: createTime.toString(),
              phone: user.phone,
              pass: AppHelper.generateMd5(pass)))
          .whenComplete(() {
        Navigator.pop(context, user);
      });
    });
    appController.loading.hide();
  }
}
