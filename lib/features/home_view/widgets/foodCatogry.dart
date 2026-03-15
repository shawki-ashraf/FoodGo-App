// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:foodapp/core/constants/colors.dart';
import 'package:foodapp/shared/custom_text.dart';

// ignore: must_be_immutable
class FoodCatogry extends StatefulWidget {
  FoodCatogry({
    required this.catogry, required this.selectedindex, required Function(dynamic index) onCategorySelected, super.key,
  });

  late int selectedindex;
  final List catogry;

  @override
  State<FoodCatogry> createState() => _FoodCatogryState();
}

class _FoodCatogryState extends State<FoodCatogry> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(widget.catogry.length, (int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                widget.selectedindex = index;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: widget.selectedindex == index
                    ? AppColors.primery
                    : const Color(0xffF3F4F6),
                borderRadius: BorderRadius.circular(20),
              ),
              child: CustomText(
                text: widget.catogry[index],
                weight: FontWeight.w600,
                color: widget.selectedindex == index
                    ? Colors.white
                    : Colors.grey.shade700,
                size: 15,
              ),
            ),
          );
        }),
      ),
    );
  }
}
