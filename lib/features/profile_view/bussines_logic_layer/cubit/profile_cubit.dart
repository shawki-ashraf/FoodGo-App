import 'package:bloc/bloc.dart';
import 'package:foodapp/features/profile_view/model/profile_model.dart';
import 'package:foodapp/features/profile_view/model/profile_repo.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo profileRepo = ProfileRepo();

  ProfileCubit() : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {
      final ProfileModel profile = await profileRepo.fetchProfileData();
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String email,
    dynamic image,
    required String visa,
    String? address,
  }) async {
    emit(ProfileUpdating()); // بداية الـ loading للزر

    try {
      final success = await profileRepo.editProfile(
        name: name,
        phone: phone,
        email: email,

        address: address,
        Visa: visa,
      );

      if (success) {
        emit(ProfileEditLoaded(msg: "Profile updated successfully"));
      } else {
        emit(ProfileError(message: "Failed to update profile"));
      }
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(LogoutUpdating()); // بدل ProfileLoading عشان متسق مع بقية الـ state
    try {
      await profileRepo
          .logout(); // هنا بننادي الريبو اللي مسح التوكن و/أو نادى API
      emit(ProfileLoggedOut()); // حالة جديدة للـ logout
    } catch (e) {
      emit(ProfileError(message: e.toString())); // لو في error
    }
  }
}
