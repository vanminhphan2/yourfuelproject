import 'package:flutter/cupertino.dart';
import 'package:yourfuel/controller/app_controller.dart';
import 'package:yourfuel/models/user.dart';
import 'package:yourfuel/provider/main_provider.dart';
import 'package:yourfuel/service/firebase.dart';
import 'package:yourfuel/utils/app_utils.dart';
import 'package:provider/provider.dart';

class LoginBloc {
  void login(BuildContext context, String phone, String pass) async {
    if (phone.isEmpty || phone.length != 10) {
      appController.dialog
          .showDefaultDialog(title: "Thong bao!", message: "Sai sdt!");
      return;
    }

    if (pass.isEmpty || pass.length < 6) {
      appController.dialog
          .showDefaultDialog(title: "Thong bao!", message: "Sai pass!");
      return;
    }

    appController.loading.show();

    print("check login phone: $phone     pass: $pass");

    var isExitsPhone = await FireBase().checkExitsPhone(phone);
    if (isExitsPhone) {
      var passServer = await FireBase().checkPass(phone: phone);

      print(
          "check login pass: ${AppHelper.generateMd5(pass)}     passServer: $passServer");
      if (AppHelper.generateMd5(pass) == passServer) {
        print("Login success!");

        final user = await FireBase().getUserData(phone: phone);

        context.read<MainProvider>().userInfo = user;
        User.instance=user;
        context.read<MainProvider>().setIsLogin = true;
      } else {
        appController.dialog
            .showDefaultDialog(title: "Thong bao!", message: "Sai mat khau!");
      }
    } else {
      appController.dialog.showDefaultDialog(
          title: "Thong bao!", message: "Tai khoan khong ton tai!");
    }

    appController.loading.hide();
  }
}
