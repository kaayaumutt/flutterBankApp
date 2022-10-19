import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterBankApp/service/dialog.dart';
import 'package:flutter/material.dart';

import '../screens/bank_home_screen.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
var bankProducts = _firestore.collection("bankProducts");

class FirebaseHelper extends BuildDialog {
  late String name;
  late String surName;
  late String tcNo;
  late String password;
  late String phoneNumber;
  late String balance;

  FirebaseHelper(this.name, this.surName, this.tcNo, this.password,
      this.phoneNumber, this.balance);

  FirebaseHelper.withSign(this.tcNo, this.password);

  void databaseAdd(BuildContext context) async {
    var docRef = bankProducts.doc("new-id-$tcNo");
    try {
      await docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
        },
        onError: (e) => print("Veriye ulaşırken hata oluştu: $e"),
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return buildAlertMessage(
              "Hata", "Bu Tc No adresine kayıtlı hesap bulunmaktadır!.");
        },
      );
    } catch (e) {
      try {
        await docRef.set({
          'name': name,
          'surName': surName,
          'tcNo': tcNo,
          'password': password,
          'phoneNumber': phoneNumber,
          'balance': balance
        }).onError((e, _) => print("Veriyi yazarken hata oluştu!"));
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return buildAlertMessageGetHome(
                "Başarı", "Başarıyla kayıt oldunuz.", context);
          },
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return buildAlertMessage("Hata", "Veriyi yazarken hata oluştu!.");
          },
        );
      }
    }
  }

  void getDatabaseSign(BuildContext context) async {
    var docRef = bankProducts.doc("new-id-$tcNo");
    try {
      await docRef.get().then((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        if (data["password"] == password) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BankHomePage(
                      data["name"],
                      data["surName"],
                      tcNo,
                      password,
                      data["phoneNumber"],
                      data["balance"])));
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return buildAlertMessage(
                  "Hata", "Hesap şifresini yanlış girdiniz.");
            },
          );
        }
      }, onError: (e) => print("Veriyi getirirken hata oluştu!"));
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return buildAlertMessage("Hata", "Bu hesap bulunamadı.");
        },
      );
    }
  }

  void updateDatabaseBalance(String balance) async {
    await bankProducts.doc("new-id-$tcNo").update({"balance": balance});
  }

  void updateDatabaseBuyerBalance(String buyerTcNo, String buyerAmount,
      String senderbalance, BuildContext context) async {
    var updateBalance;
    try {
      await bankProducts.doc("new-id-$buyerTcNo").get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          updateBalance = data["balance"];
        },
        onError: (e) => print("Veriye ulaşırken hata oluştu: $e"),
      );
      var buyerTotalBalance = int.parse(updateBalance) + int.parse(buyerAmount);

      //sender balance update
      await bankProducts.doc("new-id-$tcNo").update({"balance": senderbalance});

      //buyer balance update
      await bankProducts
          .doc("new-id-$buyerTcNo")
          .update({"balance": buyerTotalBalance.toString()});
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return buildAlertMessage("Hata", "Bu hesap bulunamadı.");
        },
      );
    }
  }
}
