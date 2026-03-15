part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final ProfileModel profile;
  ProfileLoaded(this.profile);
}

final class ProfileEditLoaded extends ProfileState {
  final String msg;
  ProfileEditLoaded({required this.msg});
}

final class ProfileUpdating extends ProfileState {}

final class LogoutUpdating extends ProfileState {}

class ProfileLoggedOut extends ProfileState {}

final class ProfileError extends ProfileState {
  final String message;
  ProfileError({required this.message});
}
