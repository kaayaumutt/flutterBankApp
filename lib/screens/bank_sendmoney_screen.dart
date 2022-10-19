import 'package:flutterBankApp/database/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bank_register_screen.dart';

class BankSendMoneyScreen extends StatefulWidget {
  @override
  late String tcNo;
  late String password;
  late String balance;
  BankSendMoneyScreen(this.tcNo, this.password, this.balance);
  State<BankSendMoneyScreen> createState() =>
      _BankSendMoneyScreenState(tcNo, password, balance);
}

var controlBuyerTcNo = TextEditingController();
var controlBuyerAmount = TextEditingController();

class _BankSendMoneyScreenState extends State<BankSendMoneyScreen> {
  late String tcNo;
  late String password;
  late String balance;
  _BankSendMoneyScreenState(this.tcNo, this.password, this.balance);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 217, 230, 102),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //icon
              Icon(Icons.send, size: 100),
              SizedBox(height: 10),

              //first text
              buildFirstText(),
              SizedBox(height: 10),

              //tcno field
              buildTcNoField(),
              SizedBox(height: 10),

              //amount field
              buildAmountField(),
              SizedBox(height: 10),

              //send money button
              buildSendMoneyButton(),
              SizedBox(height: 10),

              //back button
              buildBackButton(),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildAmountField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Yatırılacak Tutar",
            ),
            maxLength: 7,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: controlBuyerAmount,
          ),
        ),
      ),
    );
  }

  Padding buildTcNoField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Gönderilecek Kullanıcı Tc No",
            ),
            maxLength: 11,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: controlBuyerTcNo,
          ),
        ),
      ),
    );
  }

  Padding buildSendMoneyButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ElevatedButton(
        child: Center(
            child: Text(
          "Tutarı Gönder",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        )),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(25),
            primary: Colors.pink,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        onPressed: () {
          sendAmount();
        },
      ),
    );
  }

  Text buildFirstText() {
    return Text(
      "Para Gönderme Ekranı",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Padding buildBackButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ElevatedButton(
        child: Center(
            child: Text(
          "Geri",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        )),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(25),
            primary: Colors.pink,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  void sendAmount() {
    FirebaseHelper firebase = FirebaseHelper.withSign(tcNo, password);
    var myBalance = int.parse(balance);
    var amount = int.parse(controlBuyerAmount.text);
    if (myBalance >= amount) {
      var newBalance = myBalance - amount;
      firebase.updateDatabaseBuyerBalance(controlBuyerTcNo.text,
          controlBuyerAmount.text, newBalance.toString(), context);
      print("Bakiyenizi Güncellediniz.");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Başarılı"),
            content: Text("Girilen tutarı gönderdiniz."),
            actions: <Widget>[
              TextButton(
                child: const Text('Tamam'),
                onPressed: () {
                  firebase.getDatabaseSign(context);
                },
              ),
            ],
          );
        },
      );
    } else {
      print("Girilen tutar fazla.");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return firebase.buildAlertMessage(
              "Hata", "Fazla tutar girdiniz.!\nBakiyeniz: $balance");
        },
      );
    }
  }
}
