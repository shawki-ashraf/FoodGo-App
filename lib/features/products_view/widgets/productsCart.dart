import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'cartText.dart'; // ملف الـ CustomTicket

class Productscart extends StatelessWidget {
  final String image;
  final String itemName;
  final double price;
  final String numoforeder;
  final String status;
  final String data;

  const Productscart({
    required this.image,
    required this.itemName,
    required this.price,
    required this.numoforeder,
    required this.status,
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      width: double.infinity,
      child: Card(
        elevation: 3,
        child: Row(
          children: <Widget>[
            /// صورة المنتج
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                image,
                height: 120,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),

            /// بيانات المنتج
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    /// Number of Order
                    CustomTicket(
                      label: "Number of Order",
                      value: numoforeder,
                      labelColor: Colors.black,
                      valueColor: Colors.grey,
                    ),

                    /// Total Price
                    CustomTicket(
                      label: "Total Price",
                      value: "${price.toStringAsFixed(2)} EGY",
                      labelColor: Colors.black,
                      valueColor: Colors.grey,
                    ),

                    /// Status
                    CustomTicket(
                      label: "Status",
                      value: status,
                      labelColor: Colors.black,
                      valueColor: Colors.grey,
                    ),

                    /// Created At
                    CustomTicket(
                      label: "Created At",
                      value: data,
                      labelColor: Colors.black,
                      valueColor: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
