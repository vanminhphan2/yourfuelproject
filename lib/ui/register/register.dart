import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yourfuel/ui/register/register_bloc.dart';
import 'package:yourfuel/utils/app_utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _bloc = RegisterBloc();
  TextEditingController phoneValue = TextEditingController();
  TextEditingController codeValue = TextEditingController();
  TextEditingController passValue = TextEditingController();

  final onCanInputCode = PublishSubject<bool>();

  @override
  void initState() {
    phoneValue.text = "0329269019";
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
        child: StreamBuilder<bool>(
            stream: onCanInputCode.stream,
            initialData: false,
            builder: (context, snapshot) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10.0, left: 30, right: 30),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 4,
                          child: TextField(
                            enabled: !snapshot.data!,
                            controller: phoneValue,
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            decoration:
                                const InputDecoration(labelText: "Phone"),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: InkWell(
                            onTap: () {
                              if (!snapshot.data!) {
                                _bloc.getCodeClick(phoneValue.text, onCanInputCode);
                              }
                            },
                            child: Container(
                              height: 50,
                              margin:
                                  const EdgeInsets.only(left: 20, right: 10),
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
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
                    padding:const EdgeInsets.only(top: 10.0, left: 30, right: 30),
                    child: TextField(
                      enabled: snapshot.data,
                      controller: passValue,
                      maxLength: 50,
                      keyboardType: TextInputType.text,
                      decoration:
                      const InputDecoration(labelText: "New password"),
                    ),
                  ),
                  Padding(
                      padding:
                          const EdgeInsets.only(top: 10.0, left: 30, right: 30),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              flex: 4,
                              child: TextField(
                                enabled: snapshot.data,
                                controller: codeValue,
                                maxLength: 6,
                                keyboardType: TextInputType.number,
                                decoration:
                                    const InputDecoration(labelText: "Code"),
                              )),
                          Expanded(
                            flex: 3,
                            child: InkWell(
                              onTap: () {
                                if (snapshot.data!) {
                                  _bloc.verifyClick(context,passValue.text,codeValue.text);
                                }
                              },
                              child: Container(
                                height: 50,
                                margin:
                                    const EdgeInsets.only(left: 20, right: 10),
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
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              );
            }),
      ),
    );
  }
}
