import 'package:bloc/bloc.dart';

import 'package:foodapp/features/products_deatails/model/cart_model.dart';
import 'package:foodapp/features/products_deatails/model/deatails_repo.dart';

part 'toppings_state.dart';

class ToppingsCubit extends Cubit<ToppingsState> {
  final TopingRepo topingRepo = TopingRepo();
  ToppingsCubit() : super(ToppingsInitial());

  Future<void> fetchToppings() async {
    emit(ToppingsLoading());
    try {
      final Map<String, dynamic> response = await topingRepo.topingdata();

      if (response['data'] == null) {
        emit(ToppingsError('No toppings data found'));
        return;
      }

      final List<ProductToppings> toppings = List<ProductToppings>.from(
        response['data'].map((e) => ProductToppings.fromJson(e)),
      );

      emit(ToppingsLoaded(toppings));
    } catch (e) {
      emit(ToppingsError(e.toString()));
    }
  }
}
