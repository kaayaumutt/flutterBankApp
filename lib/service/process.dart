import 'package:flutterBankApp/database/firebase_helper.dart';

import 'package:flutter/material.dart';

class Process extends FirebaseHelper {
  Process(super.name, super.surName, super.tcNo, super.password,
      super.phoneNumber, super.balance);

  bool processRegisterControl(BuildContext context) {
    if (name != "" &&
        name.length > 2 &&
        surName != "" &&
        surName.length > 3 &&
        tcNo != "" &&
        tcNo.length == 11 &&
        password != "" &&
        phoneNumber != "" &&
        phoneNumber.length == 10 &&
        balance != "") {
      return true;
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return buildAlertMessage(
              "Hata", "Girilen değerler hatalı tekrar deneyiniz.!");
        },
      );
      return false;
    }
  }
}
