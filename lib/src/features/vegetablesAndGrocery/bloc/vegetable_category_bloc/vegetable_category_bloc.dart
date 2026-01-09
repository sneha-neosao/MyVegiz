import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/core/usecases/usecase.dart';
import 'package:myvegiz_flutter/src/features/home/domain/usecase/home_slider_usecase.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/domain/usecase/vegetable_category_usecase.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/domain/usecase/vegetable_slider_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/home_slider_model/home_slider_response.dart';
import 'package:myvegiz_flutter/src/remote/models/vegetable_slider_model/vegetable_category_response.dart';
import 'package:myvegiz_flutter/src/remote/models/vegetable_slider_model/slider_response.dart';
import '../../../../core/utils/logger.dart';

part 'vegetable_category_event.dart';
part 'vegetable_category_state.dart';

/// Handles state management for **Vegetable Category** and its related entities.

class VegetableCategoryBloc extends Bloc<VegetableCategoryEvent, VegetableCategoryState> {
  final VegetableCategoryUseCase _vegetableCategoryUseCase;

  VegetableCategoryBloc(this._vegetableCategoryUseCase)
      : super(VegetableCategoryInitialState()) {
    on<VegetableCategoryGetEvent>(_vegetableSlider);
  }

  Future _vegetableSlider(VegetableCategoryGetEvent event, Emitter emit) async {
    emit(VegetableCategoryLoadingState());

    final result = await _vegetableCategoryUseCase(
      VegetableCategoryParams(
        offset: event.offset,
        mainCategoryCode: event.mainCategoryCode,
      ),
    );

    result.fold(
          (l) => emit(VegetableCategoryFailureState(l.message)),
          (r) => emit(VegetableCategorySuccessState(r)),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE VegetableCategoryBloc =====");
    return super.close();
  }
}
