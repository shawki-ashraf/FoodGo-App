import 'package:foodapp/core/network/api_error.dart';
import 'package:dio/dio.dart';

class ApiExceptions {
  static ApiError handeleError(DioException error) {
    final int? statuisCode = error.response?.statusCode;
    final data = error.response?.data;

    // لو الـ backend رجع JSON وفيه message
    if (data is Map<String, dynamic> && data["message"] != null) {
      throw ApiError(message: data["message"], statuiscode: statuisCode);
    }

    // حالة خاصة
    if (statuisCode == 302) {
      throw ApiError(
        message: "This Email Already Taken",
        statuiscode: statuisCode,
      );
    }

    if (statuisCode == 500) {
      throw ApiError(
        message: ApiError(
          message: error.toString(),
          statuiscode: statuisCode,
        ).toString(),
        statuiscode: statuisCode,
      );
    }

    // أنواع DioException
    switch (error.type) {
      case DioException.connectionTimeout:
        return ApiError(message: "Bad connection", statuiscode: statuisCode);
      case DioException.badResponse:
        return ApiError(message: error.toString(), statuiscode: statuisCode);
      default:
        return ApiError(
          message: "Something went wrong",
          statuiscode: statuisCode,
        );
    }
  }
}
