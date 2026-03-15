import 'package:bloc/bloc.dart';
import 'package:foodapp/core/network/api_error.dart';
import 'package:foodapp/features/auth_view/Login_view/model/user_model.dart';
import 'package:foodapp/features/auth_view/Login_view/model/user_repo.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepo userRepo = UserRepo();
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    try {
      final UserModel user = await userRepo.login(email, password);
      emit(LoginSuccess(user));
    } catch (e) {
      if (e is ApiError) {
        emit(LoginFailure(e));
      } else {
        emit(LoginFailure(ApiError(message: e.toString())));
      }
    }
  }
}
