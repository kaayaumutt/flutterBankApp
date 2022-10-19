import 'package:flutterBankApp/database/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bank_register_screen.dart';

class BankWithdrawMoneyScreen extends StatefulWidget {
  late String tcNo;
  late String password;
  late String balance;
  BankWithdrawMoneyScreen(this.tcNo, this.password, this.balance);
  @override
  State<BankWithdrawMoneyScreen> createState() =>
      _BankWithdrawMoneyScreenState(tcNo, password, balance);
}

var controlBalance = TextEditingController();

class _BankWithdrawMoneyScreenState extends State<BankWithdrawMoneyScreen> {
  late String tcNo;
  late String password;
  late String balance;
  _BankWithdrawMoneyScreenState(this.tcNo, this.password, this.balance);
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
              Icon(Icons.attach_money, size: 100),
              SizedBox(height: 10),

              //first text
              buildFirstText(),
              SizedBox(height: 10),

              //amount field
              buildAmountField(),
              SizedBox(height: 10),

              //send money button
              buildWithdrawMoneyButton(),
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
              hintText: "Çekilecek Tutar",
            ),
            maxLength: 7,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: controlBalance,
          ),
        ),
      ),
    );
  }

  Padding buildWithdrawMoneyButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ElevatedButton(
        child: Center(
            child: Text(
          "Tutarı Çek",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        )),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(25),
            primary: Colors.pink,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        onPressed: () {
          withdrawAmount();
        },
      ),
    );
  }

  Text buildFirstText() {
    return Text(
      "Para Çekme Ekranı",
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

  void withdrawAmount() {
    FirebaseHelper firebase = FirebaseHelper.withSign(tcNo, password);
    var myBalance = int.parse(balance);
    var amount = int.parse(controlBalance.text);
    if (myBalance >= amount) {
      var newBalance = myBalance - amount;
      firebase.updateDatabaseBalance(newBalance.toString());
      print("Bakiyenizi Güncellediniz.");
      firebase.getDatabaseSign(context);
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
