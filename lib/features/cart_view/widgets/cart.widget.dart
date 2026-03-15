import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottom extends StatelessWidget {
  const CustomBottom({
    super.key,
    required this.text,
    required this.onTap,
    this.price,
  });

  final String text;
  final VoidCallback? onTap;
  final String? price;

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onTap == null;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GestureDetector(
        onTap: isDisabled ? null : onTap,
        child: Container(
          height: 55.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: isDisabled ? Colors.grey.shade400 : Colors.red,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Center(
            child: price == null
                ? Text(
                    text, // 👈 يظهر النص فقط
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
                        "$price EGY", // 👈 هنا السعر
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
