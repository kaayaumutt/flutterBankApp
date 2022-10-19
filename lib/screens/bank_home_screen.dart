import 'package:flutterBankApp/database/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bank_deposit_screen.dart';
import 'bank_register_screen.dart';
import 'bank_sendmoney_screen.dart';
import 'bank_withdraw_screen.dart';

class BankHomePage extends StatefulWidget {
  @override
  late String name;
  late String surName;
  late String tcNo;
  late String password;
  late String phoneNumber;
  late String balance;
  BankHomePage(this.name, this.surName, this.tcNo, this.password,
      this.phoneNumber, this.balance);
  State<BankHomePage> createState() => _BankPageState(this.name, this.surName,
      this.tcNo, this.password, this.phoneNumber, this.balance);
}

class _BankPageState extends State<BankHomePage> {
  late String name;
  late String surName;
  late String tcNo;
  late String password;
  late String phoneNumber;
  late String balance;
  _BankPageState(this.name, this.surName, this.tcNo, this.password,
      this.phoneNumber, this.balance);
  @override
  Widget build(BuildContext context) {
    print(tcNo);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 217, 230, 102),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //icon
              Icon(Icons.boy, size: 100),
              SizedBox(height: 10),

              //first text
              buildFirstText(),
              SizedBox(height: 10),

              //balance
              buildBalance(),
              SizedBox(height: 5),

              //balance withdraw button
              buildWithdrawButton(),
              SizedBox(height: 5),

              //balance deposit button
              buildDepositButton(),
              SizedBox(height: 5),

              //balance send button
              buildSendButton(),
              SizedBox(height: 5),

              //process button
              buildExitButton(),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }

  Text buildFirstText() {
    return Text(
      "Merhaba, " + name.toUpperCase() + " " + surName.toUpperCase(),
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Container buildBalance() {
    return Container(
      color: Colors.pink,
      height: 170,
      child: Center(
        child: Text(
          balance + " TL",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
    );
  }

  Padding buildWithdrawButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ElevatedButton(
        child: Center(
            child: Text(
          "Para Çek",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        )),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(25),
            primary: Colors.pink,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BankWithdrawMoneyScreen(tcNo, password, balance)));
        },
      ),
    );
  }

  Padding buildDepositButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ElevatedButton(
        child: Center(
            child: Text(
          "Para Yatır",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        )),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(25),
            primary: Colors.pink,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BankDepositMoneyScreen(tcNo, password, balance)));
        },
      ),
    );
  }

  Padding buildSendButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ElevatedButton(
        child: Center(
            child: Text(
          "Para Gönder",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        )),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(25),
            primary: Colors.pink,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      BankSendMoneyScreen(tcNo, password, balance)));
        },
      ),
    );
  }

  Padding buildExitButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ElevatedButton(
        child: Center(
            child: Text(
          "Çıkış",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        )),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(25),
            primary: Colors.pink,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        onPressed: () {
          SystemNavigator.pop();
        },
      ),
    );
  }
}
