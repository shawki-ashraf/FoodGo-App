import 'package:bloc/bloc.dart';
import 'package:foodapp/features/products_view/model/cartproducts.dart';
import 'package:foodapp/features/products_view/model/cartproducts_repo.dart';
import 'package:meta/meta.dart';

part 'productshistory_state.dart';

class ProductshistoryCubit extends Cubit<ProductshistoryState> {
  final CartproductsRepo cartproductsRepo = CartproductsRepo();

  ProductshistoryCubit() : super(ProductshistoryInitial());

  // دالة لجلب بيانات تاريخ الطلبات
  Future<void> getProductHistory() async {
    emit(ProductshistoryLoading()); // الحالة أثناء التحميل
    try {
      final data = await cartproductsRepo.getproductshictory();
      emit(ProductshistoryLoaded(data: data)); // الحالة بعد التحميل
    } catch (e) {
      emit(ProductshistoryError(msg: e.toString())); // حالة الخطأ
    }
  }
}
