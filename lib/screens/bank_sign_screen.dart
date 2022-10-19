import 'package:flutterBankApp/database/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bank_register_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

var controlTcNo = TextEditingController();
var controlPassword = TextEditingController();

class _MyHomePageState extends State<MyHomePage> {
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
              Icon(Icons.money, size: 100),
              SizedBox(height: 10),

              //first text
              buildFirstText(),
              SizedBox(height: 10),

              //second text
              buildSecondText(),
              SizedBox(height: 30),

              //tcno field
              buildTcNoField(),
              SizedBox(height: 10),

              //password field
              buildPasswordField(),
              SizedBox(height: 10),

              //sign in button
              buildSigninButton(),

              //not a member?register now
              buildMemberandRegister(),
            ],
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
              hintText: "Tc No",
            ),
            maxLength: 11,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: controlTcNo,
          ),
        ),
      ),
    );
  }

  Padding buildPasswordField() {
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
              hintText: "Şifre",
            ),
            obscureText: true,
            maxLength: 24,
            controller: controlPassword,
          ),
        ),
      ),
    );
  }

  Padding buildSigninButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ElevatedButton(
        child: Center(
            child: Text(
          "Giriş yap",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        )),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(25),
            primary: Colors.pink,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        onPressed: () {
          FirebaseHelper firebaseSign = new FirebaseHelper.withSign(
              controlTcNo.text, controlPassword.text);
          firebaseSign.getDatabaseSign(context);
        },
      ),
    );
  }

  Row buildMemberandRegister() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Üye değilmisin,",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          child: Text("Şimdi üye ol"),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterPage()));
          },
        )
      ],
    );
  }

  Text buildFirstText() {
    return Text(
      "Merhaba Dostum,",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text buildSecondText() {
    return Text(
      "Untitled Bankaya Hoş Geldin.",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
