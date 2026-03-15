import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodapp/core/constants/colors.dart';
import 'package:foodapp/features/cart_view/bussines_logic_layer/cubit/cartitem_cubit.dart';
import 'package:foodapp/features/home_view/bussines_logic_layer/home_cubit.dart';
import 'package:foodapp/features/home_view/model/productsmodel.dart';
import 'package:foodapp/features/home_view/widgets/foodCatogry.dart';
import 'package:foodapp/features/home_view/widgets/home_text.dart';
import 'package:foodapp/features/home_view/widgets/serch_field.dart';
import 'package:foodapp/features/products_deatails/view/details.dart';
import 'package:foodapp/shared/custom_text.dart';
import 'package:gap/gap.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Homeview extends StatefulWidget {
  const Homeview({super.key});

  @override
  State<Homeview> createState() => _HomeviewState();
}

class _HomeviewState extends State<Homeview> {
  final List<String> catogryname = <String>[
    "All",
    "Combos",
    "Burger",
    "Sliders",
    "Classic",
  ];
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: <Widget>[
            SvgPicture.asset(
              "assets/Foodgo.svg",
              fit: BoxFit.cover,
              color: AppColors.miniblac,
            ),
            const Spacer(),
            Icon(
              CupertinoIcons.person_circle,
              color: AppColors.miniblac,
              size: 40.sp,
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomText(
              text: "Order your favourite food!",
              size: 16,
              color: AppColors.grey,
              weight: FontWeight.normal,
            ),
            const TextfieldData(),
            SizedBox(height: 15.h),
            FoodCatogry(
              catogry: catogryname,
              selectedindex: selectedCategoryIndex,
              onCategorySelected: (dynamic index) {
                setState(() {
                  selectedCategoryIndex = index;
                });
              },
            ),
            Gap(25.h),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (BuildContext context, HomeState state) {
                  Widget content;

                  if (state is Loading) {
                    // Skeleton placeholders مشابهة لشكل العناصر النهائي
                    content = GridView.builder(
                      padding: EdgeInsets.only(
                        bottom: 130.h,
                        top: 0.h,
                        right: 5.w,
                        left: 5.w,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.60,
                        crossAxisSpacing: 5.w,
                        mainAxisSpacing: 5.h,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Skeletonizer(
                          enabled: true,
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // الصورة placeholder
                                Container(
                                  width: double.infinity,
                                  height: 120.h,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                Gap(10.h),
                                // اسم المنتج placeholder
                                Container(
                                  width: double.infinity,
                                  height: 15.h,
                                  color: Colors.grey.shade300,
                                ),
                                Gap(5.h),
                                // الوصف placeholder
                                Container(
                                  width: double.infinity,
                                  height: 12.h,
                                  color: Colors.grey.shade300,
                                ),
                                const Gap(10),
                                // rating placeholder
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 40.w,
                                      height: 14.h,
                                      color: Colors.grey.shade300,
                                    ),
                                    Container(
                                      width: 20.w,
                                      height: 14.h,
                                      color: Colors.grey.shade300,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is Loaded) {
                    final List<Productsmodel> products = state.homeProducts;

                    content = GridView.builder(
                      padding: EdgeInsets.only(
                        bottom: 130.h,
                        top: 0.h,
                        right: 5.w,
                        left: 5.w,
                      ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.60,
                        crossAxisSpacing: 5.w,
                        mainAxisSpacing: 5.h,
                      ),
                      itemCount: products.length,
                      itemBuilder: (BuildContext context, int index) {
                        final product = products[index];

                        return Container(
                          padding: const EdgeInsets.only(bottom: 15),
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => BlocProvider(
                                  create: (_) => CartitemCubit(),
                                  child: Details(
                                    id: product.id,
                                    image: product.image,
                                    rate: product.rate,
                                    name: product.name,
                                    dec: product.dec,
                                    price: product.price,
                                  ),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Image.network(
                                        product.image,
                                        fit: BoxFit.contain,
                                        width: 150.w,
                                        height: 120.h,
                                      ),
                                      Positioned(
                                        child: Center(
                                          child: Transform.translate(
                                            offset: Offset(0, 95.h),
                                            child: Container(
                                              width: 120.w,
                                              height: 10.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(90),
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.85),
                                                    blurRadius: 23,
                                                    spreadRadius: 5,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  CustomText(
                                    text: product.name,
                                    size: 14,
                                    color: Colors.black,
                                    weight: FontWeight.bold,
                                  ),
                                  Gap(5.h),
                                  CustomDescriptionText(
                                    text: product.dec,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                  const Gap(10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        CustomText(
                                          text: "${product.rate} ⭐",
                                          size: 14,
                                          color: Colors.black,
                                          weight: FontWeight.bold,
                                        ),
                                        Icon(
                                          CupertinoIcons.heart,
                                          size: 22.sp,
                                          color: AppColors.miniblac,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is HomeError) {
                    content = Center(
                      child: CustomText(
                        text: "Error loading products",
                        size: 16,
                        color: AppColors.miniblac,
                        weight: FontWeight.bold,
                      ),
                    );
                  } else {
                    content = const SizedBox.shrink();
                  }

                  return content;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
