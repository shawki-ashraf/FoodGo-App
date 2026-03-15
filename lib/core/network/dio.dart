import 'dart:developer';
import 'package:dio/dio.dart';

import 'package:foodapp/core/utiles/prefhelper.dart';

class DioClient {
  late final Dio dio;

  DioClient() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://sonic-zdi0.onrender.com/api',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        // ⬇️ Follow redirects و validateStatus عشان 302 ما يكراش
        followRedirects: true,
        validateStatus: (status) => status != null && status < 500,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'User-Agent': 'PostmanRuntime/7.36.1', // يقلّد Postman
        },
      ),
    );

    // ⬇️ Cookie manager للتعامل مع أي redirects لو الـ API اعتمدت عليها

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final String? token = await PrefHelper.getToken();

          if (token != null && token.isNotEmpty && token != 'guest') {
            options.headers['Authorization'] = 'Bearer $token';
          }

          log('📤 REQUEST → ${options.method} ${options.uri}');
          log('Headers: ${options.headers}');
          if (options.data != null) {
            log('Body: ${options.data}');
          }

          handler.next(options);
        },
        onResponse: (response, handler) {
          log(
            '✅ RESPONSE ← ${response.statusCode} ${response.requestOptions.path}',
          );
          log('Data: ${response.data}');
          handler.next(response);
        },
        onError: (DioException e, handler) async {
          log('❌ ERROR ← ${e.response?.statusCode}');
          log('Message: ${e.message}');

          // ⬇️ لو 401 اعمل clear للـ token
          if (e.response?.statusCode == 401) {
            await PrefHelper.clearToken();
          }

          handler.next(e);
        },
      ),
    );
  }
}
