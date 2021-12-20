import 'package:flutter/material.dart';
import 'package:yourfuel/service/firebase.dart';
import 'package:yourfuel/utils/app_utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController phoneValue = TextEditingController();
  TextEditingController codeValue = TextEditingController();

  @override
  void initState() {
    phoneValue.text="0963389695";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: phoneValue,
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Phone"),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () async {
                        await FireBase().registerUser(
                            phoneValue.text,
                            context,
                            (p0) => print("rio111 => "+p0.smsCode.toString()),
                            (p0) => print("rio222 => "+p0.code),
                            (p0, p1) => print("rio333 => "+p0),
                            (p0) => print("rio444 => "+(p0??"")));
                      },
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.only(left: 20, right: 10),
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
                          "Get code",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: TextField(
                      controller: codeValue,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: "Code"),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.only(left: 20, right: 10),
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
                          "Verify",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
