import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodapp/core/constants/colors.dart';
import 'package:foodapp/shared/custom_text.dart';

class Checkbook extends StatefulWidget {
  final VoidCallback? onAddToCart;
  final String operation;
  const Checkbook({
    required this.onAddToCart,
    required this.operation,
    super.key,
  });

  @override
  State<Checkbook> createState() => _CheckbottomState();
}

class _CheckbottomState extends State<Checkbook> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onAddToCart,
      child: Container(
        width: double.infinity,

        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: AppColors.miniblac,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Center(
          child: CustomText(
            text: widget.operation,
            size: 18,
            color: Colors.white,
            weight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
