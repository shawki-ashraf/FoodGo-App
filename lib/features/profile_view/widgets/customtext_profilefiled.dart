// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextFieldProfile extends StatelessWidget {
  const CustomTextFieldProfile({
    required this.controller,
    required this.label,
    super.key,
    this.textInputType,
    this.icon,
  });

  final TextEditingController controller;
  final String label;
  final TextInputType? textInputType;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: TextField(
        controller: controller,
        keyboardType: textInputType,

        cursorColor: Colors.white,
        cursorHeight: 15,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black),
          suffix: icon,

          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
