import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodapp/features/cart_view/bussines_logic_layer/cubit/cartitem_cubit.dart';
import 'package:foodapp/features/cart_view/widgets/cart.widget.dart';
import 'package:foodapp/features/cart_view/widgets/itemCard.dart';
import 'package:foodapp/features/checkcart_view/view/checkout_view.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class Cartview extends StatefulWidget {
  const Cartview({super.key});

  @override
  State<Cartview> createState() => _CartviewState();
}

class _CartviewState extends State<Cartview> {
  Widget cartTitle() {
    return Center(
      child: Text(
        "My Cart",
        style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          return context.read<CartitemCubit>().fetchCartItem();
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocBuilder<CartitemCubit, CartitemState>(
              builder: (context, state) {
                /// Loading
                if (state is CartitemLoading) {
                  return Column(
                    children: [
                      const SizedBox(height: 10),

                      cartTitle(),

                      const SizedBox(height: 20),

                      Expanded(
                        child: ListView.separated(
                          key: const PageStorageKey('cart_skeleton'),
                          itemCount: 5,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }

                /// Error
                if (state is CartitemError) {
                  return Center(child: Text(state.message));
                }

                /// Empty Cart
                if (state is CartitemLoaded && state.items.isEmpty) {
                  return Column(
                    children: [
                      const SizedBox(height: 10),

                      cartTitle(),

                      const Expanded(
                        child: Center(child: Text('Your cart is empty')),
                      ),
                    ],
                  );
                }

                /// Loaded
                if (state is CartitemLoaded) {
                  final cartItems = state.items;

                  final double totalPrice = cartItems.fold(0.0, (sum, item) {
                    final double itemPrice = double.tryParse(item.price) ?? 0.0;
                    return sum + itemPrice * item.quantity;
                  });

                  return Column(
                    children: [
                      const SizedBox(height: 10),

                      cartTitle(),

                      const SizedBox(height: 20),

                      Expanded(
                        child: ListView.separated(
                          key: const PageStorageKey('cart_list'),
                          itemCount: cartItems.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final item = cartItems[index];

                            return Itemcard(
                              key: ValueKey(item.itemId),
                              portion: item.quantity,
                              spicyLevel: item.spicy,
                              itemName: item.name,
                              price: double.tryParse(item.price) ?? 0.0,
                              image: item.image,
                              deleteIcon: CupertinoIcons.delete,
                              onDelete: () async {
                                await context.read<CartitemCubit>().clearCart(
                                  item.itemId,
                                );
                              },
                              qty: item.quantity.toString(),
                            );
                          },
                        ),
                      ),

                      CustomBottom(
                        text: 'Checkout',
                        price: totalPrice.toString(),
                        onTap: () async {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => BlocProvider.value(
                                value: context.read<CartitemCubit>(),
                                child: CheckView(
                                  cartItems: cartItems,
                                  totalPrice: totalPrice,
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      Gap(30.h),
                    ],
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),
        ),
      ),
    );
  }
}
