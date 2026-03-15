import 'package:bloc/bloc.dart';
import 'package:foodapp/features/products_deatails/model/cart_model.dart';
import 'package:foodapp/features/products_deatails/model/deatails_repo.dart';
import 'package:meta/meta.dart';

part 'sideoptions_state.dart';

class SideoptionsCubit extends Cubit<SideoptionsState> {
  final SideoptionRepo sideoptionRepo = SideoptionRepo();
  SideoptionsCubit() : super(SideoptionsInitial());
  Future<void> fetchToppings() async {
    emit(SideoptionsLoading());
    try {
      final Map<String, dynamic> response = await sideoptionRepo.sideoptiondata();

      if (response['data'] == null) {
        emit(SideoptionsError('No toppings data found'));
        return;
      }

      final List<ProductToppings> sideoptions = List<ProductToppings>.from(
        response['data'].map((e) => ProductToppings.fromJson(e)),
      );

      emit(SideoptionsLoaded(sideoptions));
    } catch (e) {
      emit(SideoptionsError(e.toString()));
    }
  }
}
