import 'package:foodapp/core/network/api_error.dart';
import 'package:foodapp/core/network/api_service.dart';
import 'package:foodapp/features/products_deatails/model/cart_model.dart';

class DeatailsRepo {
  final ApiService _apiService = ApiService();

  Future<void> cartdata(CartModel cartdata) async {
    try {
      await _apiService.post("/cart/add", {
        "items": [cartdata.toJson()],
      });
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}

class TopingRepo {
  final ApiService _apiService = ApiService();
  Future<Map<String, dynamic>> topingdata() async {
    try {
      return await _apiService.get("/toppings");
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}

class SideoptionRepo {
  final ApiService _apiService = ApiService();
  Future<Map<String, dynamic>> sideoptiondata() async {
    try {
      return await _apiService.get("/side-options");
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
