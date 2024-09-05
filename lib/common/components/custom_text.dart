import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  CustomText({super.key,required this.controller, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: 
      InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),),
        hintText: hintText,
        hintStyle: TextStyle(
        fontSize: 16,
        color: Colors.grey,
        ),
        ),
      style: TextStyle(
        fontSize: 18,
        ),
        );
  }
}