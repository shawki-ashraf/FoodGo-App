part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class Loading extends HomeState {}

class Loaded extends HomeState {
  final List<Productsmodel> homeProducts;

  Loaded(this.homeProducts);
}

class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}
