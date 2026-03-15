part of 'toppings_cubit.dart';

sealed class ToppingsState {}

final class ToppingsInitial extends ToppingsState {}

final class ToppingsLoading extends ToppingsState {}

final class ToppingsLoaded extends ToppingsState {
  final List<ProductToppings> toppings;

  ToppingsLoaded(this.toppings);
}

final class ToppingsError extends ToppingsState {
  final String message;

  ToppingsError(this.message);
}
