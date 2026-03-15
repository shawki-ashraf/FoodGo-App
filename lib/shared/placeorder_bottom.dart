import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomplaceorde extends StatelessWidget {
  const CustomBottomplaceorde({
    super.key,
    required this.text,
    required this.onTap,
    this.price,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onTap;
  final String? price;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onTap == null || isLoading;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GestureDetector(
        onTap: isDisabled ? null : onTap,
        child: Container(
          height: 55.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDisabled ? Colors.grey.shade400 : Colors.red,
            borderRadius: BorderRadius.circular(35.r),
          ),
          child: Center(
            child: isLoading
                ? SizedBox(
              height: 24.h,
              width: 24.w,
              child: const CircularProgressIndicator(
                strokeWidth: 2.5,
                color: Colors.white,
              ),
            )
                : price == null
                ? Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.w),
                Container(
                  height: 18.h,
                  width: 1.w,
                  color: Colors.white70,
                ),
                SizedBox(width: 10.w),
                Text(
                  "${price!} EGY",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
