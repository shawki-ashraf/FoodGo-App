part of 'sideoptions_cubit.dart';

@immutable
sealed class SideoptionsState {}

final class SideoptionsInitial extends SideoptionsState {}

final class SideoptionsLoading extends SideoptionsState {}

final class SideoptionsLoaded extends SideoptionsState {
  final List<ProductToppings> sideoptions;
  SideoptionsLoaded(this.sideoptions);
}

final class SideoptionsError extends SideoptionsState {
  final String message;
  SideoptionsError(this.message);
}
