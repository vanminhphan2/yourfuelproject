import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yourfuel/ui/register/register.dart';
import 'package:yourfuel/utils/app_utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneValue = TextEditingController();
  TextEditingController passValue = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 70,
                child: TextField(
                  controller: phoneValue,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Phone"),
                ),
              ),
              SizedBox(
                height: 70,
                child: TextField(
                  controller: passValue,
                  maxLength: 50,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(labelText: "Password"),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColorDark
                            ])),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              InkWell(
                  onTap: () async {
                    print("click to register..");
                    AppHelper.navigatePush(context, AppScreenName.dailyCheck, const RegisterPage());
                  },
                  child: const Text("Register account",
                      style: TextStyle(
                          color: AppColors.primaryColor, fontWeight: FontWeight.bold)))
            ],
          ),
        ),
      ),
    );
  }
}
