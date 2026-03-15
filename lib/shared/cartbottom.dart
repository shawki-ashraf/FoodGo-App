import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodapp/shared/custom_text.dart';

class Cartbottom extends StatefulWidget {
  final double? width;
  final double totalPrice;
  final VoidCallback onAddToCart;
  final String operation;
  const Cartbottom({
    required this.totalPrice,
    required this.onAddToCart,
    required this.operation,
    super.key,
    this.width,
  });

  @override
  State<Cartbottom> createState() => _CartbottomState();
}

class _CartbottomState extends State<Cartbottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 15.h),
      height: 100.h,
      width: widget.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              const CustomText(
                text: "Total Price",
                size: 16,
                color: Colors.black,
                weight: FontWeight.normal,
              ),
              CustomText(
                text: "${widget.totalPrice} EGY",
                size: 24,
                color: Colors.red,
                weight: FontWeight.bold,
              ),
            ],
          ),

          GestureDetector(
            onTap: widget.onAddToCart,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: CustomText(
                text: widget.operation,
                size: 16,
                color: Colors.white,
                weight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
