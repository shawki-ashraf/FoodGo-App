import 'package:foodapp/core/network/api_error.dart';
import 'package:foodapp/core/network/api_service.dart';
import 'package:foodapp/core/utiles/prefhelper.dart';
import 'package:foodapp/features/auth_view/Login_view/model/user_model.dart';

class UserRepo {
  final ApiService apiService = ApiService();

  Future<UserModel> login(String email, String password) async {
    try {
      final response = await apiService.post("/login", <String, String>{
        "email": email,
        "password": password,
      });

      if (response is ApiError) throw response;

      if (response is Map<String, dynamic>) {
        final msg = response["message"];
        final code = response["code"];
        final data = response["data"];
        if (code != 200 || data == null) throw ApiError(message: msg);

        final UserModel user = UserModel.fromjson(data);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }
        return user;
      } else {
        throw ApiError(message: "Unexpected Error From Server");
      }
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
