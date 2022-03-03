import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vtys_kalite/componenets/custom_text.dart';
import 'package:vtys_kalite/utilities/style.dart';

String? nameLetters(name) {
  var words = name.split(' ');
  String letters = name.length > 0
      ? (words[0][0] +
          (words.length > 1 ? ("" + words[words.length - 1][0]) : ""))
      : "";
  return letters != "" ? letters.toUpperCase() : "";
}

randomColor() {
  return (Random().nextDouble() * 0xFFFFFFFF).toInt();
}

showDialogDoneMessage(context, {String text = "İşlem Kaydedildi."}) async {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: Container(
        color: lightColor,
        width: 250,
        height: 250,
        child: Center(
          child: Wrap(
            children: [
              Center(
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: lightColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Icon(
                        Icons.done,
                        size: 50,
                        color: successfulColor,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Center(
                  child: CustomText(
                    text: text,
                    size: 24,
                    weight: FontWeight.w500,
                    color: successfulColor,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: CustomText(
                    text: "Çıkmak için\n Ekranda herhangi bir yere tıklayın.",
                    size: 14,
                    weight: FontWeight.w200,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ).then((value) => Get.back());
}

showDialogWaitingMessage(context) async {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: Container(
        color: lightColor,
        width: 200,
        height: 200,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(),
              ),
              CustomText(
                text: "İşlem Bekleniyor",
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }
}
