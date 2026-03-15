import 'package:bloc/bloc.dart';
import 'package:foodapp/features/cart_view/model/itemcart_repo.dart';
import 'package:foodapp/features/checkcart_view/model/itemcheck_rebo.dart';
import 'package:foodapp/features/products_deatails/model/cart_model.dart';
import 'package:foodapp/features/products_deatails/model/deatails_repo.dart';

part 'cartitem_state.dart';

class CartitemCubit extends Cubit<CartitemState> {
  final CartItemRepo itemcartRepo = CartItemRepo();
  final DeatailsRepo cartRepo = DeatailsRepo();
  final ItemcheckRebo itemcheckRebo = ItemcheckRebo();

  final DeleteCartItemRepo deleteCartItemRepo = DeleteCartItemRepo();

  CartitemCubit() : super(CartitemInitial());

  // get data cart function

  Future<void> fetchCartItem() async {
    if (isClosed) return;
    emit(CartitemLoading());
    try {
      final response = await itemcartRepo.fetchCartItems();
      if (isClosed) return;
      emit(CartitemLoaded(items: response.cartdata.items));
    } catch (e) {
      if (isClosed) return;
      emit(CartitemError(e.toString()));
    }
  }

  Future<void> saveorder(Map<String, dynamic> body) async {
    if (isClosed) return;
    final currentState = state;
    try {
      await itemcartRepo.addCartItem(body);

      // تحديث الكارت فوراً في الواجهة
      if (currentState is CartitemLoaded) {
        final newItem = CartItemModel(
          itemId: DateTime.now().millisecondsSinceEpoch,
          productId: body['product_id'],
          name: body['name'] ?? 'Item',
          price: body['price'].toString(),
          quantity: body['quantity'],
          image: body['image'] ?? '',
          spicy: body['spicy'].toString(),
        );
        final updatedItems = List<CartItemModel>.from(currentState.items)
          ..add(newItem);
        emit(CartitemLoaded(items: updatedItems));
      } else {
        await fetchCartItem();
      }
    } catch (e) {
      emit(CartitemError(e.toString()));
    }
  }

  Future<void> clearCart(int cartItemId) async {
    final currentState = state;
    if (currentState is CartitemLoaded) {
      try {
        await deleteCartItemRepo.deleteCartItem(cartItemId);
        final updatedItems = currentState.items
            .where((item) => item.itemId != cartItemId)
            .toList();
        emit(CartitemLoaded(items: updatedItems));
      } catch (e) {
        emit(CartitemError(e.toString()));
      }
    }
  }

  void clearAllCart() {
    if (isClosed) return;
    emit(CartitemLoaded(items: []));
  }

  Future<void> checkout(List<CartItemModel> items) async {
    try {
      final cartModels = items
          .map(
            (e) => CartModel(
              productId: e.productId,
              quantity: e.quantity,
              spicy: double.tryParse(e.spicy) ?? 0,
              toppings: [],
              sideOptions: [],
              name: e.name,
              price: e.price,
              image: e.image,
            ),
          )
          .toList();
      await itemcartRepo.createOrder(cartModels);
      clearAllCart(); // مسح الكارت بعد الدفع مباشرة
    } catch (e) {
      emit(CartitemError(e.toString()));
    }
  }

  // add to cart function

  Future<void> addToCart(CartModel cartdata) async {
    try {
      emit(CartitemLoading());

      await cartRepo.cartdata(cartdata);

      emit(CartLoaded("Item added to cart successfully"));
    } catch (e) {
      emit(CartitemError(e.toString()));
    }
  }

  //check out function

  Future<void> placeOrder(
    List<CartItemModel> cartItems,
    double totalPrice,
  ) async {
    if (isClosed) return;
    emit(CartitemLoading());

    try {
      final itemsBody = cartItems.map((item) {
        double spicyLevel = double.tryParse(item.spicy) ?? 0.1;
        if (spicyLevel < 0.1) spicyLevel = 0.1;

        return {
          "product_id": item.productId,
          "quantity": item.quantity,
          "spicy": spicyLevel,
          "toppings": [],
          "side_options": [],
        };
      }).toList();

      final body = {"items": itemsBody};
      await itemcheckRebo.sendCheckitemData(body);

      if (isClosed) return;
      emit(ItemcheckLoaded());
    } catch (e) {
      if (isClosed) return;
      emit(CartitemError(e.toString()));
    }
  }
}
