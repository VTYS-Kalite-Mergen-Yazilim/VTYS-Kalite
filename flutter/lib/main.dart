import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vtys_kalite/routes.dart';
import 'package:vtys_kalite/screens/LoginPage/login_page.dart';
import 'package:vtys_kalite/utilities/constans.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VTYS Kalite',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        backgroundColor: kBackColor,
      ),
      initialRoute: LoginPage.routeName,
      routes: routes,
    );
  }
}

