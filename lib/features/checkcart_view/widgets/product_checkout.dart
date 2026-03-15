// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:foodapp/shared/custom_text.dart';
import 'package:gap/gap.dart';

class ProductChechout extends StatefulWidget {
  const ProductChechout({
    required this.order,
    required this.taxes,
    required this.fees,
    required this.total,
    super.key,
  });

  final String order, taxes, fees, total;

  @override
  State<ProductChechout> createState() => _ProductChechoutState();
}

class _ProductChechoutState extends State<ProductChechout> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        checkorder("Order", widget.order, false, false),
        const Gap(10),
        checkorder("Taxes", widget.taxes, false, false),
        const Gap(10),
        checkorder("Delivery fees", widget.fees, false, false),
        const Gap(10),
        const Divider(),

        checkorder("Item:", widget.total, true, false),
        const Gap(20),
        checkorder("Estimated delivery time:", "15 - 30 mins", true, true),
      ],
    );
  }
}

Widget checkorder(text, price, isbold, issmall) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      CustomText(
        text: text,
        size: issmall ? 16 : 18,
        color: isbold ? Colors.black : const Color(0xff7D7D7D),
        weight: isbold ? FontWeight.bold : null,
      ),
      CustomText(
        text: price,
        size: issmall ? 16 : 18,
        color: isbold ? Colors.black : const Color(0xff7D7D7D),
        weight: isbold ? FontWeight.bold : null,
      ),
    ],
  );
}
