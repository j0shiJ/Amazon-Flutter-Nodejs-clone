import 'dart:convert';

import 'package:amazon_clone/Features/home/screens/home_screen.dart';
import 'package:amazon_clone/constants/error_handler.dart';
import 'package:amazon_clone/constants/global_variable.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //Signup User
  void signUpUser({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      User user = User(
          id: '',
          email: email,
          name: name,
          password: password,
          address: '',
          type: '',
          token: '');
      var uri0 = "$uri/api/signup";
      http.Response res = await http.post(
        Uri.parse(uri0),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            "Account created!",
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

// signin function
  void signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      var uri0 = "$uri/api/signin";
      http.Response res = await http.post(
        Uri.parse(uri0),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      httpErrorHandler(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          prefs.setString(
            'x-auth-token',
            jsonDecode(res.body)['token'],
          );
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.routeName, (route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      // http.Response res = await http.post(
      //   Uri.parse(uri0),
      //   body: jsonEncode({
      //     'email': email,
      //     'password': password,
      //   }),
      //   headers: <String, String>{
      //     'Content-Type': 'application/json; charset=UTF-8'
      //   },
      // );
      // httpErrorHandler(
      //   response: res,
      //   context: context,
      //   onSuccess: () async {
      //     SharedPreferences prefs = await SharedPreferences.getInstance();
      //     Provider.of<UserProvider>(context, listen: false).setUser(res.body);
      //     prefs.setString(
      //       'x-auth-token',
      //       jsonDecode(res.body)['token'],
      //     );
      //     Navigator.pushNamedAndRemoveUntil(
      //         context, HomeScreen.routeName, (route) => false);
      //   },
      // );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
