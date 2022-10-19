import 'package:flutterBankApp/database/firebase_helper.dart';
import 'package:flutterBankApp/service/process.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

var controlName = TextEditingController();
var controlSurname = TextEditingController();
var controlTcNo = TextEditingController();
var controlPassword = TextEditingController();
var controlPhoneNumber = TextEditingController();

class _RegisterPageState extends State<RegisterPage> {
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
              Icon(Icons.app_registration, size: 75),
              SizedBox(height: 5),

              //first text
              buildFirstText(),
              SizedBox(height: 10),

              //name field
              buildNameField(),
              SizedBox(height: 5),

              //surname field
              buildSurnameField(),
              SizedBox(height: 5),

              //tcno field
              buildTcNoField(),
              SizedBox(height: 5),

              //password field
              buildPasswordField(),
              SizedBox(height: 5),

              //phonenumber field
              buildPhoneNumberField(),
              SizedBox(height: 5),

              //register button
              buildRegisterButton(),
              SizedBox(height: 5),
              //back button
              buildBackButton(),
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
            controller: controlTcNo,
            maxLength: 11,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
            controller: controlPassword,
            obscureText: true,
            maxLength: 24,
          ),
        ),
      ),
    );
  }

  Padding buildRegisterButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: ElevatedButton(
        child: Center(
            child: Text(
          "Kayıt Ol",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        )),
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(25),
            primary: Colors.pink,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        onPressed: () {
          Process firebaseHelp = Process(
              controlName.text,
              controlSurname.text,
              controlTcNo.text,
              controlPassword.text,
              controlPhoneNumber.text,
              "0");
          if (firebaseHelp.processRegisterControl(context)) {
            firebaseHelp.databaseAdd(context);
            //Navigator.pop(context);
          }
        },
      ),
    );
  }

  Text buildFirstText() {
    return Text(
      "Kayıt Ekranı",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Padding buildNameField() {
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
          child: TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "İsim",
            ),
            controller: controlName,
            maxLength: 24,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[A-Z.,a-z.]')),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildSurnameField() {
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
              hintText: "Soy İsim",
            ),
            controller: controlSurname,
            maxLength: 12,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[A-Z.,a-z.]')),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildPhoneNumberField() {
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
              hintText: "Telefon Numarası",
            ),
            controller: controlPhoneNumber,
            maxLength: 10,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
        ),
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
}
