// ignore: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodapp/core/constants/colors.dart';

class CustomTextfield extends StatefulWidget {
  const CustomTextfield({
    required this.hint,
    required this.isPassword,
    required this.controller,
    super.key,
  });

  final String hint;
  final bool isPassword;
  final TextEditingController controller;

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _togglepassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (String? v) {
        if (v == null || v.isEmpty) {
          return "please write your ${widget.hint}";
        }
        return null;
      },
      obscureText: widget.isPassword ? _obscureText : false,
      cursorHeight: 20,
      cursorColor: AppColors.primery,
      style: const TextStyle(fontSize: 20),

      decoration: InputDecoration(
        labelText: widget.hint,
        labelStyle: TextStyle(color: AppColors.grey, fontSize: 20),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 30,
        ),
        hintStyle: TextStyle(color: AppColors.grey),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  _togglepassword();
                },
                child: Icon(CupertinoIcons.eye, color: AppColors.primery),
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColors.grey, width: 3),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColors.miniblac, width: 3),
        ),
      ),
    );
  }
}
