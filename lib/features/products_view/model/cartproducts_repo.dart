import 'package:foodapp/core/network/api_service.dart';
import 'package:foodapp/features/products_view/model/cartproducts.dart';

class CartproductsRepo {
  final ApiService apiService = ApiService();

  Future<productcart> getproductshictory() async {
    try {
      final res = await apiService.get("/orders");

      // تحويل الـ response JSON إلى object
      if (res != null) {
        return productcart.fromJson(res);
      } else {
        // في حال لم يكن هناك بيانات، يمكنك إرجاع object فارغ
        return productcart(code: 0, message: "No data", data: []);
      }
    } catch (e) {
      // التعامل مع أي خطأ في الاتصال
      return productcart(code: -1, message: e.toString(), data: []);
    }
  }
}
