import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodapp/core/constants/colors.dart';
import 'package:foodapp/features/cart_view/bussines_logic_layer/cubit/cartitem_cubit.dart';
import 'package:foodapp/features/cart_view/view/cartview.dart';
import 'package:foodapp/features/home_view/bussines_logic_layer/home_cubit.dart';
import 'package:foodapp/features/home_view/view/homeview.dart';
import 'package:foodapp/features/products_view/bussines_logic_layer/cubit/productshistory_cubit.dart';
import 'package:foodapp/features/products_view/view/productview.dart';
import 'package:foodapp/features/profile_view/bussines_logic_layer/cubit/profile_cubit.dart';
import 'package:foodapp/features/profile_view/view/profileview.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int currentScreen = 0;

  late final HomeCubit _homeCubit;
  late final ProfileCubit _profileCubit;
  late final CartitemCubit _cartCubit;
  late final ProductshistoryCubit _productshistoryCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = HomeCubit()..getData();
    _profileCubit = ProfileCubit();
    _cartCubit = CartitemCubit()..fetchCartItem();
    _productshistoryCubit = ProductshistoryCubit();
  }

  @override
  void dispose() {
    _homeCubit.close();
    _profileCubit.close();
    _cartCubit.close();
    _productshistoryCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _homeCubit),
        BlocProvider.value(value: _profileCubit),
        BlocProvider.value(value: _cartCubit),
        BlocProvider.value(value: _productshistoryCubit),
      ],
      child: Scaffold(
        extendBody: true,
        body: IndexedStack(
          index: currentScreen,
          children: [
            const Homeview(),
            BlocBuilder<CartitemCubit, CartitemState>(
              builder: (context, state) {
                return Cartview(key: ValueKey(state.hashCode));
              },
            ),
            const Productview(),
            const Profileview(),
          ],
        ),
        bottomNavigationBar: Container(
          height: 74.h,
          margin: EdgeInsets.fromLTRB(25.w, 0, 25.w, 20.h),
          decoration: BoxDecoration(
            color: AppColors.orange,
            borderRadius: BorderRadius.circular(25.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25.r),
            child: BlocBuilder<CartitemCubit, CartitemState>(
              builder: (context, state) {
                final int count = state is CartitemLoaded
                    ? state.items.length
                    : 0;

                return BottomNavigationBar(
                  currentIndex: currentScreen,
                  backgroundColor: Colors.transparent,
                  type: BottomNavigationBarType.fixed,
                  elevation: 0,
                  selectedItemColor: Colors.black,
                  unselectedItemColor: Colors.white.withOpacity(0.8),
                  showSelectedLabels: true,
                  showUnselectedLabels: false,
                  onTap: (int index) {
                    setState(() {
                      currentScreen = index;
                      switch (index) {
                        case 0:
                          _homeCubit.getData();
                          break;
                        case 1:
                          _cartCubit.fetchCartItem();
                          break;
                        case 2:
                          _productshistoryCubit.getProductHistory();
                          break;
                        case 3:
                          _profileCubit.loadProfile();
                          break;
                      }
                    });
                  },
                  items: [
                    const BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.home),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Badge(
                        label: Text('$count'),
                        isLabelVisible: count > 0,
                        child: const Icon(CupertinoIcons.cart),
                      ),
                      label: "Cart",
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.local_restaurant_sharp),
                      label: "Orders",
                    ),
                    const BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.person),
                      label: "Profile",
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
