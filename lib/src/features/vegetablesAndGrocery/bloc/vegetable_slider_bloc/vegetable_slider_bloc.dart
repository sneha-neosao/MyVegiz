import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/core/usecases/usecase.dart';
import 'package:myvegiz_flutter/src/features/home/domain/usecase/home_slider_usecase.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/domain/usecase/vegetable_slider_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/home_slider_model/home_slider_response.dart';
import 'package:myvegiz_flutter/src/remote/models/slider_model/slider_response.dart';
import '../../../../core/utils/logger.dart';

part 'vegetable_slider_event.dart';
part 'vegetable_slider_state.dart';

/// Handles state management for **Slider Image List Get** and its related entities.

class VegetableSliderBloc extends Bloc<VegetableSliderEvent, VegetableSliderState> {
  final VegetableSliderUseCase _vegetableSliderUseCase;

  VegetableSliderBloc(
    this._vegetableSliderUseCase,
  ) : super(VegetableSliderInitialState()) {
    on<VegetableSliderGetEvent>(_vegetableSlider);
  }

  /// - **[_vegetableSlider]:** Handles [VegetableSliderGetEvent] → calls [HomeSliderUseCase]

  Future _vegetableSlider(VegetableSliderGetEvent event, Emitter emit) async {
    emit(VegetableSliderLoadingState());

    final result = await _vegetableSliderUseCase.call(
      VegetableSliderParams(
          cityCode: event.cityCode,
          mainCategoryCode: event.mainCategoryCode
      )
    );

    result.fold(
      (l) => emit(VegetableSliderFailureState(l.message)),
      (r) => emit(VegetableSliderSuccessState(r)),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE VegetableSliderBloc =====");
    return super.close();
  }
}
