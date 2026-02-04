import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/domain/usecase/product_by_category_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/category_by_product_model/category_by_product_response.dart';
import '../../../../core/utils/logger.dart';

part 'product_by_category_event.dart';
part 'product_by_category_state.dart';

/// Handles state management for *Product by category** and its related entities.

class ProductByCategoryBloc
    extends Bloc<ProductByCategoryEvent, ProductByCategoryState> {
  final ProductByCategoryUseCase _productByCategoryUseCase;

  /// Keeps products per category
  final Map<String, ProductByCategoryResponse> _cache = {};

  ProductByCategoryBloc(this._productByCategoryUseCase)
      : super(ProductByCategoryInitialState()) {
    on<ProductByCategoryGetEvent>(_productByCategory);
  }

  Future<void> _productByCategory(
      ProductByCategoryGetEvent event,
      Emitter<ProductByCategoryState> emit,
      ) async {
    // ❌ Do NOT emit loading every time
    // emit(ProductByCategoryLoadingState());

    final result = await _productByCategoryUseCase(
      ProductByCategoryParams(
        offset: event.offset,
        mainCategoryCode: event.mainCategoryCode,
        cityCode: event.cityCode,
        categorySName: event.categorySName,
      ),
    );

    result.fold(
          (l) => emit(ProductByCategoryFailureState(l.message)),
          (r) {
        _cache[event.categorySName] = r;
        emit(ProductByCategorySuccessState(Map.from(_cache)));
      },
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE ProductByCategoryBloc =====");
    return super.close();
  }
}

