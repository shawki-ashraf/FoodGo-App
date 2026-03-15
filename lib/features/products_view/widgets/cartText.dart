import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTicket extends StatelessWidget {
  final String label;
  final String value;
  final Color labelColor;
  final Color valueColor;

  const CustomTicket({
    required this.label,
    required this.value,
    this.labelColor = Colors.black,
    this.valueColor = Colors.grey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$label: ",
            style: TextStyle(
              color: labelColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: valueColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
