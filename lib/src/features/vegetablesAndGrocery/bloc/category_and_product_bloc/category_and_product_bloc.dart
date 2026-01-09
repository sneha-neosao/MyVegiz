import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/domain/usecase/category_and_product_usecase.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/domain/usecase/category_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/category_and_product_model/category_and_product_response.dart';
import 'package:myvegiz_flutter/src/remote/models/category_model/category_response.dart';
import '../../../../core/utils/logger.dart';

part 'category_and_product_event.dart';
part 'category_and_product_state.dart';

/// Handles state management for *Category and Product** and its related entities.

class CategoryAndProductBloc extends Bloc<CategoryAndProductEvent, CategoryAndProductState> {
  final CategoryAndProductUseCase _categoryAndProductUseCase;

  CategoryAndProductBloc(this._categoryAndProductUseCase)
      : super(CategoryAndProductInitialState()) {
    on<CategoryAndProductGetEvent>(_slider);
  }

  Future _slider(CategoryAndProductGetEvent event, Emitter emit) async {
    emit(CategoryAndProductLoadingState());

    final result = await _categoryAndProductUseCase(
      CategoryAndProductParams(
        cityCode: event.cityCode,
        offset: event.offset,
        mainCategoryCode: event.mainCategoryCode,
      ),
    );

    result.fold(
          (l) => emit(CategoryAndProductFailureState(l.message)),
          (r) => emit(CategoryAndProductSuccessState(r)),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE CategoryAndProductBloc =====");
    return super.close();
  }
}
