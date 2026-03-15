import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight? weight;
  const CustomText({
    required this.text,
    required this.size,
    required this.color,
    required this.weight,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: size.sp, fontWeight: weight, color: color),
    );
  }
}
