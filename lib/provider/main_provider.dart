import 'package:flutter/material.dart';

class MainProvider extends ChangeNotifier{
   bool _isLogin=false;
   bool get isLogin=> _isLogin;
    void setIsLogin(bool value){
       _isLogin=value;
       notifyListeners();
    }
}