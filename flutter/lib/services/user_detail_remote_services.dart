// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vtys_kalite/models/User%20Detail/user_detail.dart';
import 'package:vtys_kalite/routing/routes.dart';

class UserDetailServices {
  static Encoding? encoding = Encoding.getByName('utf-8');

  static Future<UserDetail?> fetchUserDetailById(userId) async {
    var response =
        await http.get(Uri.parse(serviceHttp + '/userdetail/list/$userId'));
    UserDetail? user;
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var jsonString = utf8.decode(response.bodyBytes);
      if (jsonString == "null") {
        return null;
      }
      jsonString = "[" + jsonString + "]";
      user = parseUser(jsonString);
    }
    return user;
  }

  static Future<int> addNewUserDetail(String json) async {
    print(json);
    var response = await http
        .post(
          Uri.parse(serviceHttp + '/userdetail/new'),
          headers: <String, String>{
            'Content-type': 'application/json',
            'Accept': 'application/json',
          },
          body: json,
          encoding: encoding,
        )
        .timeout(
          const Duration(seconds: 10),
        );
    return response.statusCode;
  }

  static Future<String> updateUserDetail(int id, String json) async {
    var response = await http
        .put(Uri.parse(serviceHttp + '/userdetail/update/$id'),
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
              //'Authorization': '<Your token>'
            },
            body: json,
            encoding: encoding)
        .timeout(
          const Duration(seconds: 10),
        );
    return (response.statusCode >= 200 && response.statusCode < 300)
        ? "Success: User"
        : "Error: User ${response.statusCode}";
  }

  static Future<String> deleteUserDetail(int id) async {
    var response = await http
        .delete(Uri.parse(serviceHttp + '/userdetail/remove/$id'),
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
              //'Authorization': '<Your token>'
            },
            encoding: encoding)
        .timeout(
          const Duration(seconds: 10),
        );
    return (response.statusCode >= 200 && response.statusCode < 300)
        ? "Success: User"
        : "Error: User ${response.statusCode}";
  }
}
