import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vtys_kalite/componenets/custom_alert_dialog.dart';
import 'package:vtys_kalite/componenets/custom_text_box.dart';
import 'package:vtys_kalite/componenets/custom_text_divider.dart';
import 'package:vtys_kalite/core/statics.dart';
import 'package:vtys_kalite/componenets/custom_button.dart';
import 'package:vtys_kalite/screens/ActivityForm/main_form_page.dart';
import 'package:vtys_kalite/screens/SignUp/sign_up.dart';
import 'package:vtys_kalite/utilities/constants.dart';

class LoginPage extends StatefulWidget {
  static String routeName = '/LoginPage';

  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width / 4),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Form(
                key: _loginKey,
                child: Column(
                  children: [
                    usernameTextBox(),
                    passwordTextBox(),
                    const SizedBox(height: 10),
                    loginButton(context),
                    CustomTextDivider(text: "OR", thickness: 2),
                    signUpButton(context),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  CustomButton loginButton(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return CustomButton(
      title: "Login",
      pressAction: () async {
        int id = await Statics.instance.userController
            .fetchUser(_usernameController.text, _passwordController.text);
        if (id == -1) {
          showDialog(
            context: context,
            builder: (_) => CustomAlertDialog(
              titleWidget: _usernameController.text != ""
                  ? RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: _usernameController.text,
                              style: kLabelHeader2Style),
                          const TextSpan(
                              text: " için yanlış kullanıcı adı veya şifre",
                              style: kLabelHeader3Style),
                        ],
                      ),
                    )
                  : const Text(
                      "Kullanıcı adı veya şifre boş bırakılamaz.",
                      style: kLabelHeader3Style,
                      textAlign: TextAlign.center,
                    ),
              bodyWidget: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text(
                        "Girdiğiniz şifre veya kullanıcı adı yanlış. Lütfen tekrar deneyiniz."),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                        title: "Tekrar Dene",
                        pressAction: () {
                          Get.back();
                        }),
                  ],
                ),
              ),
              bodyWidgetWidth: screenSize.width / 3,
            ),
          );
          return;
        }
        if (_loginKey.currentState!.validate()) {
          Statics.instance.setUser(null);
          Statics.instance.username = _usernameController.text;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString("username", _usernameController.text);
          Navigator.pushReplacementNamed(context, MainFormPage.routeName);
        }
      },
    );
  }

  CustomButton signUpButton(BuildContext context) {
    return CustomButton(
        title: "Sign Up",
        pressAction: () {
          Navigator.pushReplacementNamed(context, SignUpPage.routeName);
        });
  }

  CustomTextBox passwordTextBox() {
    return CustomTextBox(
      controller: _passwordController,
      title: "Password",
      label: "Password",
      validator: (val) {
        if (val!.isEmpty) {
          return "Cannot Be Blank";
        } else if (val.length < 6) {
          return "Minimum 6 Character";
        } else {
          return null;
        }
      },
      obscureText: true,
      decorationIcon: const Icon(Icons.lock),
    );
  }

  CustomTextBox usernameTextBox() {
    return CustomTextBox(
      controller: _usernameController,
      title: "Username",
      label: "Username",
      validator: (val) {
        if (val!.isEmpty) {
          return "Cannot Be Blank";
        } else {
          return null;
        }
      },
      decorationIcon: const Icon(Icons.person),
    );
  }
}
