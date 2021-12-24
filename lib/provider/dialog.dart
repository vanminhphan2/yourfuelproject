import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogController{
  final BuildContext context;

  DialogController(this.context);

  /// normal dialog
  void showDefaultDialog({String? title, String? message}) {
    if (context == null) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AppDialog(title: title,message: message),
    );
  }
}

class AppDialog extends StatelessWidget {
  final title;
  final message;

  const AppDialog({Key? key, this.title = "Alert", this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        TextButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            child: Text("OK")),
      ],
    );
  }
}
