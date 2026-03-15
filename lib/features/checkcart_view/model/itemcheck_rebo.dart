import 'package:foodapp/core/network/api_service.dart';

class ItemcheckRebo {
  final ApiService apiServiceb = ApiService();
  Future<void> sendCheckitemData(Map<String, dynamic> data) async {
    final response = await apiServiceb.post("/orders", data);

    // بدل statusCode، استخدم code من JSON
    if (response['code'] != 201) {
      throw Exception("Failed to place order");
    }

    // طباعة رسالة و order_id
    print("Message: ${response['message']}");
    print("Order ID: ${response['data']['order_id']}");
  }
}
