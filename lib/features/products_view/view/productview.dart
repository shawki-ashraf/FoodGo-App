import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:foodapp/features/products_view/bussines_logic_layer/cubit/productshistory_cubit.dart';
import 'package:foodapp/features/products_view/widgets/productsCart.dart';
import 'package:foodapp/shared/custom_text.dart';

class Productview extends StatefulWidget {
  const Productview({super.key});

  @override
  State<Productview> createState() => _ProductviewState();
}

class _ProductviewState extends State<Productview> {
  @override
  void initState() {
    super.initState();
    // استدعاء Cubit عند فتح الصفحة
    context.read<ProductshistoryCubit>().getProductHistory();
  }

  // Skeleton Loader
  Widget buildSkeletonItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(width: 80, height: 80, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 15,
                    color: Colors.grey,
                    margin: const EdgeInsets.only(bottom: 8),
                  ),
                  Container(
                    height: 15,
                    color: Colors.grey,
                    margin: const EdgeInsets.only(bottom: 8),
                  ),
                  Container(height: 15, width: 100, color: Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              text: "My Orders",
              size: 24,
              color: Colors.black,
              weight: FontWeight.bold,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<ProductshistoryCubit, ProductshistoryState>(
                builder: (context, state) {
                  if (state is ProductshistoryLoading) {
                    // عرض Skeleton Loader أثناء التحميل
                    return ListView.builder(
                      itemCount: 6, // عدد العناصر الوهمية
                      itemBuilder: (context, index) => buildSkeletonItem(),
                    );
                  } else if (state is ProductshistoryLoaded) {
                    final orders = state.data.data ?? [];
                    if (orders.isEmpty) {
                      return const Center(child: Text("No orders found."));
                    }
                    return ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final item = orders[index];
                        return Productscart(
                          image: item.productImage ?? "assets/image4.png",
                          itemName: "Order #${item.id}",
                          price: double.tryParse(item.totalPrice ?? "0") ?? 0,
                          numoforeder: "Order #${item.id}",
                          status: item.status ?? "pending",
                          data: item.createdAt ?? "",
                        );
                      },
                    );
                  } else if (state is ProductshistoryError) {
                    return Center(child: Text("Error: ${state.msg}"));
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
