// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vtys_kalite/models/user.dart';
import 'package:vtys_kalite/routing/routes.dart';

class UserRemoteServices {
  static Encoding? encoding = Encoding.getByName('utf-8');

  static Future<List<User>?> fetchUsers() async {
    var response = await http.get(Uri.parse(serviceHttp + '/user/list'));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return parseUsers(utf8.decode(response.bodyBytes));
    } else {
      return null;
    }
  }

  static Future<User?> fetchUserById(id) async {
    var response = await http.get(Uri.parse(serviceHttp + '/user/list/$id'));
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var jsonString = utf8.decode(response.bodyBytes);
      if (jsonString == "null") {
        return null;
      }
      jsonString = "[" + jsonString + "]";
      return parseUser(jsonString);
    }
    return null;
  }

  static Future<int> fetchUserByName(String name) async {
    var response = await http.get(Uri.parse(serviceHttp + '/user/$name'));
    int userID = -1;
    if (response.statusCode >= 200 && response.statusCode < 300) {
      var jsonString = utf8.decode(response.bodyBytes);
      if (jsonString == "null") {
        return userID;
      }
      jsonString = "[" + jsonString + "]";
      User? _user = parseUser(jsonString);
      userID = _user == null ? -1 : _user.id;
    }
    return userID;
  }

  static Future<int> fetchUserByNameAndPassword(
      String name, String password) async {
    var response = await http.get(
        Uri.parse(serviceHttp + '/user/check/name:${name}&pass:${password}'));
    int userID = -1;
    if (response.statusCode >= 200 && response.statusCode < 300) {
      String jsonString = utf8.decode(response.bodyBytes);
      if (jsonString == "null") {
        return userID;
      }
      jsonString = "[" + jsonString + "]";
      User? _user = parseUser(jsonString);
      userID = _user == null ? -1 : _user.id;
    }
    return userID;
  }

  static Future<int> fetchUserByEmailAndPassword(
      String email, String password) async {
    var response = await http.get(
        Uri.parse(serviceHttp + '/user/check/email:${email}&pass:${password}'));
    int userID = -1;
    if (response.statusCode >= 200 && response.statusCode < 300) {
      String jsonString = utf8.decode(response.bodyBytes);
      if (jsonString == "null") {
        return userID;
      }
      jsonString = "[" + jsonString + "]";
      User? _user = parseUser(jsonString);
      userID = _user == null ? -1 : _user.id;
    }
    return userID;
  }

  static Future<int> addNewUser(String json) async {
    print(json);
    var response = await http
        .post(Uri.parse(serviceHttp + '/user/new'),
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
            body: json,
            encoding: encoding)
        .timeout(
          const Duration(seconds: 10),
        );
    return response.statusCode;
  }

  static Future<int> updateUser(int id, String json) async {
    var response = await http
        .put(Uri.parse(serviceHttp + '/user/update/$id'),
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
    return response.statusCode;
  }

  static Future<int> deleteUser(int id) async {
    var response = await http
        .delete(Uri.parse(serviceHttp + '/user/remove/$id'),
            headers: <String, String>{
              'Content-type': 'application/json',
              'Accept': 'application/json',
              //'Authorization': '<Your token>'
            },
            encoding: encoding)
        .timeout(
          const Duration(seconds: 10),
        );
    return response.statusCode;
  }
}
