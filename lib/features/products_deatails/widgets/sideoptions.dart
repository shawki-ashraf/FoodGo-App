import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodapp/shared/custom_text.dart';

class Sideoptions extends StatefulWidget {
  final String image;
  final String name;
  final VoidCallback onTap;
  const Sideoptions({
    required this.image, required this.name, required this.onTap, super.key,
  });

  @override
  State<Sideoptions> createState() => _SideoptionsState();
}

class _SideoptionsState extends State<Sideoptions> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 100.h,
          width: 70.w,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),

        Positioned(
          top: 10.h,
          left: 0.w,
          child: Image.network(widget.image, height: 50.h, fit: BoxFit.cover),
        ),

        Positioned(
          bottom: 10.h,
          left: 5.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              CustomText(
                text: widget.name,
                size: 12,
                color: Colors.black,
                weight: FontWeight.bold,
              ),

              GestureDetector(
                onTap: widget.onTap,
                child: Icon(
                  CupertinoIcons.plus_circled,
                  color: Colors.red,
                  size: 20.r,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
