import 'package:flutter/material.dart';
import 'package:vtys_kalite/screens/ActivityForm/activity_evaluation.dart';
import 'package:vtys_kalite/screens/ActivityForm/activity_form.dart';
import 'package:vtys_kalite/screens/ActivityForm/new_activity.dart';
import 'package:vtys_kalite/screens/SignUp/sign_up.dart';
import 'package:vtys_kalite/screens/loginpage/login_page.dart';

final Map<String, WidgetBuilder> routes = {
  LoginPage.routeName: (context) => LoginPage(),
  SignUpPage.routeName: (context) => SignUpPage(),
  ActivityFormPage.routeName: (context) =>  ActivityFormPage(),
  NewActivityPage.routeName: (context) =>  NewActivityPage(),
  ActivityEvaluationPage.routeName: (context) =>  ActivityEvaluationPage(),
};
