import 'package:dio/dio.dart';
import 'package:foodapp/core/network/api_service.dart';
import 'package:foodapp/core/utiles/prefhelper.dart';
import 'package:foodapp/features/profile_view/model/profile_model.dart';

class ProfileRepo {
  final ApiService apiService = ApiService();

  Future<ProfileModel> fetchProfileData() async {
    final response = await apiService.get('/profile');
    // response هنا Map<String, dynamic>

    if (response['code'] == 200) {
      return ProfileModel.fromJson(response['data']);
    } else {
      throw Exception(response['message'] ?? 'Failed to load profile data');
    }
  }

  Future<bool> editProfile({
    required String name,
    required String phone,
    required String email,

    required String Visa,
    String? address,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "name": name,
        "email": email,
        "phone": phone,

        "address": address ?? "",
        "Visa": Visa,
      });

      final res = await apiService.post("/update-profile", formData);

      return res != null && res["code"] == 200;
    } catch (e) {
      print("Error updating profile: $e");
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    await apiService.post("/logout", {});
    await PrefHelper.clearToken();
  }
}
