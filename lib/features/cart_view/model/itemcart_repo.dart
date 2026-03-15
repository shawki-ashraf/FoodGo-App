import 'package:foodapp/core/network/api_service.dart';
import 'package:foodapp/features/products_deatails/model/cart_model.dart';

class CartItemRepo {
  final ApiService apiService = ApiService();

  Future<GetCartResponse> fetchCartItems() async {
    final response = await apiService.get('/cart');
    if (response == null) throw Exception('Response is null');
    if (response['code'] == 200 && response['data'] != null) {
      return GetCartResponse.fromJson(response);
    } else {
      throw Exception(response['message'] ?? 'Failed to load cart');
    }
  }

  Future<void> addCartItem(Map<String, dynamic> body) async {
    final response = await apiService.post('/cart/add', body);
    if (response == null) throw Exception('Response is null');
    if (response['code'] != 200 && response['code'] != 201) {
      throw Exception(response['message'] ?? 'Failed to add item');
    }
  }

  Future<void> createOrder(List<CartModel> items) async {
    final orderItems = items.map((item) => item.toMap()).toList();
    final response = await apiService.post('/orders', {
      'items': orderItems,
      'totalPrice': items.fold<double>(
        0.0,
        (sum, item) => sum + (double.tryParse(item.price) ?? 0) * item.quantity,
      ),
    });

    if (response == null) throw Exception('Response is null');
    if (response['code'] != 200 && response['code'] != 201) {
      throw Exception(response['message'] ?? 'Failed to create order');
    }
  }
}

class DeleteCartItemRepo {
  final ApiService apiService = ApiService();

  Future<void> deleteCartItem(int cartItemId) async {
    final response = await apiService.delete('/cart/remove/$cartItemId');
    if (response == null) throw Exception('Response is null');
    if (response['code'] != 200) {
      throw Exception(response['message'] ?? 'Failed to delete item');
    }
  }
}
