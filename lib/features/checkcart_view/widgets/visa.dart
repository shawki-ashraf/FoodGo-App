import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentSection extends StatefulWidget {
  final double totalprice;
  const PaymentSection({super.key, required this.totalprice});

  @override
  State<PaymentSection> createState() => _PaymentSectionState();
}

class _PaymentSectionState extends State<PaymentSection> {
  String selectedPayment = 'card';
  bool saveCard = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment methods',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 12.h),

          /// 🔹 Cash on Delivery
          RadioListTile<String>(
            value: 'cod',
            groupValue: selectedPayment,
            onChanged: (value) {
              setState(() => selectedPayment = value!);
            },
            title: Text('Cash on Delivery', style: TextStyle(fontSize: 14.sp)),
            secondary: Image.asset('assets/dollar.png', width: 40.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            tileColor: Colors.grey[200],
          ),

          SizedBox(height: 8.h),

          /// 🔹 Debit Card
          RadioListTile<String>(
            value: 'card',
            groupValue: selectedPayment,
            onChanged: (value) {
              setState(() => selectedPayment = value!);
            },
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Debit card', style: TextStyle(fontSize: 14.sp)),
                Text(
                  '3566 **** **** 0505',
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                ),
              ],
            ),
            secondary: Image.asset('assets/credit-card.png', width: 35.w),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
            tileColor: Colors.grey[200],
          ),

          SizedBox(height: 8.h),

          /// 🔹 Save card
          CheckboxListTile(
            value: saveCard,
            onChanged: (value) {
              setState(() => saveCard = value!);
            },
            title: Text(
              'Save card details for future payments',
              style: TextStyle(fontSize: 12.sp),
            ),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),

          SizedBox(height: 16.h),

          /// 🔹 Total Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Price',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                '${widget.totalprice.toStringAsFixed(2)} EGY ',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),

          Divider(thickness: 1.h, color: Colors.grey[400]),

          /// 🔹 Error Box
        ],
      ),
    );
  }
}
