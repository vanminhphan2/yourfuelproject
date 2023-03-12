import 'package:flutter/material.dart';
import '../models/user.dart';

class MainProvider extends ChangeNotifier{

   bool _isLogin=false;

   late User _userInfo;

   set userInfo(User value) {
    _userInfo = value;
  }

   User get userInfo => _userInfo;

   bool get isLogin=> _isLogin;
   set setIsLogin(bool value){
     _isLogin=value;
     notifyListeners();
   }
   bool get hasBeenSet => _userInfo.hasBeenSet;

   set setHasBeenSet(bool value){
     _userInfo.hasBeenSet=value;
     notifyListeners();
   }


}