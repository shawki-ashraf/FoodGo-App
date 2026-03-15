import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodapp/shared/custom_text.dart';
import 'package:gap/gap.dart';

class Itemcard extends StatefulWidget {
  final int portion;
  final String spicyLevel;
  final String itemName;
  final double price;
  final String image;
  final String qty;
  final Future<void> Function()? onDelete;
  final IconData? deleteIcon;

  const Itemcard({
    required this.portion,
    required this.spicyLevel,
    required this.itemName,
    required this.price,
    required this.image,
    super.key,
    this.onDelete,
    this.deleteIcon,
    required this.qty,
  });

  @override
  State<Itemcard> createState() => _ItemcardState();
}

class _ItemcardState extends State<Itemcard> {
  late int portion;
  bool isDeleting = false;

  @override
  void initState() {
    super.initState();
    portion = widget.portion;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      width: double.infinity,
      child: Card(
        elevation: 3,
        child: Row(
          children: <Widget>[
            // صورة المنتج و التحكم في الكمية
            Image.network(
              widget.image,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomText(
                      text: widget.itemName,
                      size: 10,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    ),
                    Gap(10.h),
                    CustomText(
                      text: "Price : ${widget.price} EGY",
                      size: 10,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    ),
                    Gap(10.h),
                    CustomText(
                      text: "Spicy : ${widget.spicyLevel}",
                      size: 10,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    ),
                    Gap(10.h),
                    CustomText(
                      text: "Quantity : ${widget.qty} ",
                      size: 10,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
            ),

            // زر الحذف مع Loading
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 30),
              child: GestureDetector(
                onTap: isDeleting
                    ? null
                    : () async {
                        if (widget.onDelete != null) {
                          setState(() => isDeleting = true); // يبدأ Loading
                          await widget.onDelete!(); // تنفيذ API
                          if (mounted)
                            setState(() => isDeleting = false); // ينتهي Loading
                        }
                        return; // يضمن Future<void بدون تحذير
                      },
                child: isDeleting
                    ? SizedBox(
                        width: 20.w,
                        height: 20.h,

                        child: const CircularProgressIndicator(),
                      )
                    : Icon(widget.deleteIcon, color: Colors.red, size: 30.h),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
