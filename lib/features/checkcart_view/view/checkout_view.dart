import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodapp/features/cart_view/bussines_logic_layer/cubit/cartitem_cubit.dart';
import 'package:foodapp/features/checkcart_view/widgets/visa.dart';
import '../../products_deatails/model/cart_model.dart';
import 'package:foodapp/features/checkcart_view/widgets/checkbottom.dart';
import 'package:foodapp/features/checkcart_view/widgets/product_checkout.dart';
import 'package:foodapp/shared/custom_text.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckView extends StatefulWidget {
  const CheckView({
    super.key,
    required this.cartItems,
    required this.totalPrice,
  });

  final List<CartItemModel> cartItems;
  final double totalPrice;

  @override
  State<CheckView> createState() => _CheckViewState();
}

class _CheckViewState extends State<CheckView> {
  final double order = 10.0;
  final double taxes = 0.3;
  final double fees = 18.19;

  @override
  Widget build(BuildContext context) {
    final totalCheckoutPrice = widget.totalPrice + order + taxes + fees;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_rounded, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<CartitemCubit, CartitemState>(
        listener: (context, state) {
          if (state is ItemcheckLoaded) {
            context.read<CartitemCubit>().clearAllCart();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("✅ Order placed successfully"),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context, true);
          }

          if (state is CartitemError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is CartitemLoading;

          return Stack(
            children: [
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(20.h),
                    const CustomText(
                      text: "Order summary",
                      weight: FontWeight.bold,
                      size: 20,
                      color: Colors.black,
                    ),
                    Gap(20.h),
                    ProductChechout(
                      order: order.toString(),
                      taxes: taxes.toString(),
                      fees: fees.toString(),
                      total: totalCheckoutPrice.toStringAsFixed(2),
                    ),
                    Gap(30.h),

                    // 🔹 Payment methods section
                    PaymentSection(totalprice: totalCheckoutPrice),

                    Gap(50.h),

                    // 🔹 Pay Button
                    Checkbook(
                      operation: isLoading ? "Processing..." : "Pay Now",
                      onAddToCart: isLoading
                          ? null
                          : () {
                              context.read<CartitemCubit>().placeOrder(
                                widget.cartItems,
                                widget.totalPrice,
                              );
                            },
                    ),
                    Gap(30.h),
                  ],
                ),
              ),

              // 🔹 Loading overlay
              if (isLoading)
                Container(
                  color: Colors.black45,
                  width: 1.sw,
                  height: 1.sh,
                  child: const Center(
                    child: CupertinoActivityIndicator(radius: 20),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
