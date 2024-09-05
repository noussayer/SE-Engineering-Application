import 'package:flutter/material.dart';
String uri = 'https://server-beta-dusky-75.vercel.app';
class GlobalVariables{
  static const appBarGradient = LinearGradient(
    colors: [
       Color(0xFF9CC5FF),
       Color(0xFF7553F6),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color(0xFF7553F6);
  static const backgroundColor = Colors.white;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.cyan[800]!;
  static const unselectedNavBarColor = Colors.black87;

 
}