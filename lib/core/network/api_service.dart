import 'package:dio/dio.dart';
import 'package:foodapp/core/network/dio.dart';
import 'api_expition.dart'; // الكلاس الخاص بإدارة الأخطاء

class ApiService {
  final DioClient _dioClient = DioClient();

  ApiService();

  /// GET
  Future<dynamic> get(String endpoint) async {
    try {
      final Response response = await _dioClient.dio.get(endpoint);
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 429) {
        return null; // Rate limit
      }
      throw ApiExceptions.handeleError(e);
    }
  }

  /// POST
  Future<dynamic> post(
    String endpoint,
    dynamic body,
  ) async {
    try {
      dynamic dataToSend;

      if (body == null) {
        dataToSend = null;
      } else if (body is Map) {
        dataToSend = body;
      } else if (body is List) {
        dataToSend = body.map((e) => e is Map ? e : e.toJson()).toList();
      } else if (body is FormData) {
        dataToSend = body;
      } else {
        try {
          dataToSend = body.toJson();
        } catch (_) {
          dataToSend = body;
        }
      }

      print("=========== REQUEST ===========");
      print("URL: $endpoint");
      print("BODY: $dataToSend");

      final Response response = await _dioClient.dio.post(
        endpoint,
        data: dataToSend,
        options: body is FormData
            ? null
            : Options(headers: {"Content-Type": "application/json"}),
      );

      print("=========== RESPONSE ===========");
      print("STATUS CODE: ${response.statusCode}");
      print("DATA: ${response.data}");

      return response.data;
    } on DioException catch (e) {
      print("=========== ERROR ===========");
      print(e.response?.data);
      throw ApiExceptions.handeleError(e);
    }
  }

  /// PUT
  Future<dynamic> put(String endpoint, dynamic body) async {
    try {
      final Response response = await _dioClient.dio.put(endpoint, data: body);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handeleError(e);
    }
  }

  /// DELETE
  Future<dynamic> delete(String endpoint) async {
    try {
      final Response response = await _dioClient.dio.delete(endpoint);
      return response.data;
    } on DioException catch (e) {
      throw ApiExceptions.handeleError(e);
    }
  }
}
