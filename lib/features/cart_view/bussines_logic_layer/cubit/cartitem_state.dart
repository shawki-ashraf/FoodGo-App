part of 'cartitem_cubit.dart';

sealed class CartitemState {}

final class CartitemInitial extends CartitemState {}

final class CartitemLoading extends CartitemState {}

final class CartitemError extends CartitemState {
  final String message;
  CartitemError(this.message);
}

// DETALIES Add to cart

final class CartLoaded extends CartitemState {
  final String msg;

  CartLoaded(this.msg);
}

// Get tha cart
class CartitemLoaded extends CartitemState {
  final List<CartItemModel> items;
  final int? deletingItemId;

  CartitemLoaded({required this.items, this.deletingItemId});

  CartitemLoaded copyWith({List<CartItemModel>? items, int? deletingItemId}) {
    return CartitemLoaded(
      items: items ?? this.items,
      deletingItemId: deletingItemId,
    );
  }
}

//checkout method

final class ItemcheckLoaded extends CartitemState {}
