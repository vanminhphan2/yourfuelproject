import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:your_fuel_app/controller/app_controller.dart';
import 'package:your_fuel_app/provider/base_provider.dart';
import 'package:your_fuel_app/provider/main_provider.dart';

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
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Expanded(
            child: Container(),
            flex: 1,
          ),
          Expanded(
            flex: 1,
            child: TextField(
              controller: phoneValue,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Phone"),
            ),
          ),
          Expanded(
            flex: 1,
            child: TextField(
              controller: passValue,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: "Password"),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.only(left: 10,right: 10),
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  colors: [Theme.of(context).primaryColor,Theme.of(context).primaryColorDark])),
              child: TextButton(
                  onPressed: () async {
                    print(
                        "phone: ${phoneValue.text}    pass: ${passValue.text}");
                    appController.loading.show();
                    await Future.delayed(Duration(seconds: 2));
                    context.read<MainProvider>().setIsLogin(true);
                  },
                  child: const Text("Login",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),)),
            ),
          ),
          Expanded(
            child: Container(),
            flex: 8,
          )
        ],
      ),
    );
  }
}
