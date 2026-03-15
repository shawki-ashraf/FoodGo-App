part of 'productshistory_cubit.dart';

@immutable
sealed class ProductshistoryState {}

final class ProductshistoryInitial extends ProductshistoryState {}

final class ProductshistoryLoading extends ProductshistoryState {}

final class ProductshistoryLoaded extends ProductshistoryState {
  final productcart data;

  ProductshistoryLoaded({required this.data});
}

final class ProductshistoryError extends ProductshistoryState {
  final String msg;

  ProductshistoryError({required this.msg});
}
