// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:foodapp/core/network/api_error.dart';
import 'package:foodapp/core/network/api_service.dart';
import 'package:foodapp/features/home_view/model/productsmodel.dart';

class ProductsRepo {
  final ApiService apiService = ApiService();

  Future<List<Productsmodel>> getData() async {
    try {
      final res = await apiService.get("/products");

      if (res == null || res['data'] == null) {
        throw ApiError(message: "Empty products response");
      }

      if (res['data'] is List) {
        return (res['data'] as List)
            .map((e) => Productsmodel.fromJson(e))
            .toList();
      } else {
        throw ApiError(message: "Products data is not a list");
      }
    } catch (e) {
      if (e is ApiError) {
        rethrow;
      }
      throw ApiError(message: e.toString());
    }
  }
}
