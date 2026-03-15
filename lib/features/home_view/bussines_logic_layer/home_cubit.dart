import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:foodapp/features/home_view/model/products_repo.dart';
import 'package:foodapp/features/home_view/model/productsmodel.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ProductsRepo productsRepo = ProductsRepo();

  List<Productsmodel> products = <Productsmodel>[];
  bool _hasFetched = false; // علمة هل عملنا fetch قبل كده

  HomeCubit() : super(HomeInitial());

  Future<void> getData({bool forceRefresh = false}) async {
    // لو الداتا موجودة والكاش موجود وما فيش force refresh
    if (_hasFetched && !forceRefresh) {
      // emit بس لو الداتا مش موجودة في الحالة الحالية
      if (state is! Loaded) {
        emit(Loaded(products));
      }
      return;
    }

    emit(Loading());

    try {
      final List<Productsmodel> res = await productsRepo.getData();
      products = res;
      _hasFetched = true; // علمة أننا جلبنا الداتا
      emit(Loaded(res));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
