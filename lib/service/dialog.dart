import 'package:flutterBankApp/screens/bank_sign_screen.dart';
import 'package:flutter/material.dart';

class BuildDialog {
  AlertDialog buildAlertMessage(String title, String content) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
    );
  }

  AlertDialog buildAlertMessageGetHome(
      String title, String content, BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          child: const Text('Tamam'),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
          },
        ),
      ],
    );
  }
}
