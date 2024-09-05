import 'package:flutter/material.dart';
import 'package:se_project/common/constants/utils.dart';
import 'package:se_project/features/auth/auth_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountServices {
  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
        context, 
        AuthScreen.routeName, 
        (route) => false);
      


    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}