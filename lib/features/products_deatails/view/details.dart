import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:foodapp/core/constants/colors.dart';
import 'package:foodapp/features/cart_view/bussines_logic_layer/cubit/cartitem_cubit.dart';
import 'package:foodapp/features/products_deatails/bussines_logic_layer/cubit/sideoptions_cubit.dart';
import 'package:foodapp/features/products_deatails/bussines_logic_layer/cubit/toppings_cubit.dart';
import 'package:foodapp/features/products_deatails/model/cart_model.dart';
import 'package:foodapp/features/products_deatails/widgets/sideoptions.dart';
import 'package:foodapp/features/products_deatails/widgets/spicy.dart';
import 'package:foodapp/shared/cartbottom.dart';
import 'package:foodapp/shared/custom_text.dart';
import 'package:gap/gap.dart';
import 'package:nested/nested.dart';

class Details extends StatefulWidget {
  final String image;
  final String rate;
  final String name;
  final String dec;
  final String price;
  final int id;

  const Details({
    required this.image,
    required this.rate,
    required this.name,
    required this.dec,
    required this.price,
    required this.id,
    super.key,
  });

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  double spicyLevel = 0.5;
  int portion = 1;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <SingleChildWidget>[
        BlocProvider(create: (BuildContext context) => CartitemCubit()),
        BlocProvider(
          create: (BuildContext context) => ToppingsCubit()..fetchToppings(),
        ),
        BlocProvider(
          create: (BuildContext context) => SideoptionsCubit()..fetchToppings(),
        ),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              /// ================= TOP =================
              Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Container(
                    height: 330.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(200.r),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -100.h,
                    left: 0,
                    right: 0,
                    child: CachedNetworkImage(
                      imageUrl: widget.image,
                      height: 300.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    top: 50.h,
                    left: 20.w,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 80.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: CustomText(
                        text: widget.name,
                        size: 22,
                        color: Colors.black,
                        weight: FontWeight.bold,
                      ),
                    ),
                    Gap(5.h),
                    Center(
                      child: CustomText(
                        text: "${widget.rate}⭐",
                        size: 16,
                        color: AppColors.grey,
                        weight: FontWeight.w500,
                      ),
                    ),
                    Gap(20.h),
                    CustomText(
                      text: widget.dec,
                      size: 16,
                      color: AppColors.grey,
                      weight: FontWeight.w500,
                    ),
                    Gap(20.h),

                    /// 🔥 Spicy + Portion
                    SpicyPortionSection(
                      spicyLevel: spicyLevel,
                      portion: portion,
                      onSpicyChanged: (double value) {
                        setState(() => spicyLevel = value);
                      },
                      onPortionChanged: (int value) {
                        setState(() => portion = value);
                      },
                    ),
                    Gap(20.h),

                    const CustomText(
                      text: "Toppings",
                      size: 16,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    ),

                    /// ========= Toppings Section with Skeleton =========
                    BlocBuilder<ToppingsCubit, ToppingsState>(
                      builder: (BuildContext context, ToppingsState state) {
                        if (state is ToppingsLoading) {
                          return SizedBox(
                            height: 90.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              separatorBuilder: (_, __) => const Gap(10),
                              itemBuilder: (context, index) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: 80.w,
                                    height: 80.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        if (state is ToppingsLoaded) {
                          return SizedBox(
                            height: 90.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.toppings.length,
                              separatorBuilder: (_, __) => const Gap(10),
                              itemBuilder: (BuildContext context, int index) {
                                final ProductToppings topping =
                                    state.toppings[index];
                                return Sideoptions(
                                  image: topping.image,
                                  name: topping.name,
                                  onTap: () {},
                                );
                              },
                            ),
                          );
                        } else if (state is ToppingsError) {
                          return SizedBox(
                            height: 90.h,
                            child: Center(
                              child: CustomText(
                                text: state.message,
                                size: 14,
                                color: Colors.red,
                                weight: FontWeight.w500,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    Gap(20.h),

                    const CustomText(
                      text: "Side Options",
                      size: 16,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    ),

                    /// ========= Side Options Section with Skeleton =========
                    BlocBuilder<SideoptionsCubit, SideoptionsState>(
                      builder: (BuildContext context, SideoptionsState state) {
                        if (state is SideoptionsLoading) {
                          return SizedBox(
                            height: 90.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              separatorBuilder: (_, __) => const Gap(10),
                              itemBuilder: (context, index) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    width: 80.w,
                                    height: 80.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        if (state is SideoptionsLoaded) {
                          return SizedBox(
                            height: 90.h,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.sideoptions.length,
                              separatorBuilder: (_, __) => const Gap(10),
                              itemBuilder: (BuildContext context, int index) {
                                final ProductToppings sideoption =
                                    state.sideoptions[index];
                                return Sideoptions(
                                  image: sideoption.image,
                                  name: sideoption.name,
                                  onTap: () {},
                                );
                              },
                            ),
                          );
                        } else if (state is SideoptionsError) {
                          return SizedBox(
                            height: 90.h,
                            child: Center(
                              child: CustomText(
                                text: state.message,
                                size: 14,
                                color: Colors.red,
                                weight: FontWeight.w500,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const Gap(120),
                  ],
                ),
              ),
            ],
          ),
        ),

        /// ================= Bottom =================
        bottomSheet: BlocConsumer<CartitemCubit, CartitemState>(
          listener: (BuildContext context, CartitemState state) {
            if (state is CartLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  margin: const EdgeInsets.all(16),
                  backgroundColor: Colors.green,
                  content: const Text("Added to cart successfully"),
                ),
              );
            } else if (state is CartitemError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (BuildContext context, CartitemState state) {
            if (state is CartitemLoading) {
              return SizedBox(
                height: 80.h,
                child: const Center(child: CircularProgressIndicator()),
              );
            } else if (state is CartitemError) {
              return SizedBox(
                height: 80.h,
                child: Center(
                  child: Text(
                    state.message,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              );
            } else {
              return Cartbottom(
                totalPrice: (double.tryParse(widget.price) ?? 0) * portion,
                operation: "Add to Cart",
                onAddToCart: () {
                  final CartModel item = CartModel(
                    productId: widget.id,
                    spicy: spicyLevel,
                    toppings: <int>[],
                    quantity: portion,
                    sideOptions: [],
                    price: widget.price,
                    name: widget.name,
                    image: widget.image,
                  );
                  context.read<CartitemCubit>().addToCart(item);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
