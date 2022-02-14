import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtys_kalite/componenets/custom_alert_dialog.dart';
import 'package:vtys_kalite/componenets/custom_button.dart';
import 'package:vtys_kalite/componenets/custom_text.dart';
import 'package:vtys_kalite/componenets/custom_text_box.dart';
import 'package:vtys_kalite/componenets/custom_text_divider.dart';
import 'package:vtys_kalite/routing/routes.dart';
import 'package:vtys_kalite/utilities/controllers.dart';
import 'package:vtys_kalite/utilities/style.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 12),
                    child: CustomText(
                      text: "Mergen Tech",
                      color: darkColor,
                      size: 24,
                      weight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Text(
                    "Login",
                    style: GoogleFonts.roboto(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              CustomTextBox(
                controller: _usernameController,
                label: "Name",
                hint: "abcdef",
              ),
              const SizedBox(height: 15),
              CustomTextBox(
                controller: _passwordController,
                label: "Password",
                hint: "******",
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (val) {},
                      ),
                      const CustomText(
                        text: "Remember Me",
                      ),
                    ],
                  ),
                  CustomText(
                    text: "Forgot Password",
                    color: activeColor,
                  ),
                ],
              ),
              const SizedBox(height: 15),
              CustomButton(
                title: "Login",
                backgroundColor: activeColor,
                foregroundColor: Colors.white,
                pressAction: () => loginButton(context),
              ),
              CustomTextDivider(
                text: "OR",
              ),
              CustomButton(
                title: "Sign Up",
                backgroundColor: activeColor,
                foregroundColor: Colors.white,
                pressAction: () => Get.offAllNamed(signUpPageRoute),
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  loginButton(context) async {
    int id = await userController.fetchUserByNameAndPassword(
        _usernameController.text, _passwordController.text);
    if (id == -1) {
      showDialog(
        context: context,
        builder: (_) => CustomAlertDialog(
          titleWidget: _usernameController.text != ""
              ? CustomText(
                  text: _usernameController.text +
                      " için yanlış kullanıcı adı veya şifre",
                )
              : const CustomText(
                  text: "Kullanıcı adı veya şifre boş bırakılamaz.",
                ),
          bodyWidget: SingleChildScrollView(
            child: Column(
              children: [
                const CustomText(
                  text:
                      "Girdiğiniz şifre veya kullanıcı adı yanlış. Lütfen tekrar deneyiniz.",
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  title: "Tekrar Dene",
                  pressAction: () {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
          bodyWidgetWidth: MediaQuery.of(context).size.width / 3,
        ),
      );
      return;
    }
    /* if (_loginKey.currentState!.validate()) {
      Statics.instance.setUser(null);
      Statics.instance.username = _usernameController.text;
      //////////7
    } */
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("username", _usernameController.text);
    Get.offAllNamed(rootRoute);
  }
}
