import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/domain/usecase/slider_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/slider_model/slider_response.dart';
import '../../../../core/utils/logger.dart';

part 'slider_event.dart';
part 'slider_state.dart';

/// Handles state management for **Image List Get** and its related entities.

class SliderBloc extends Bloc<SliderEvent, SliderState> {
  final SliderUseCase _sliderUseCase;

  SliderBloc(
    this._sliderUseCase,
  ) : super(SliderInitialState()) {
    on<SliderGetEvent>(_slider);
  }

  /// - **[_slider]:** Handles [SliderGetEvent] → calls [SliderUseCase]

  Future _slider(SliderGetEvent event, Emitter emit) async {
    emit(SliderLoadingState());

    final result = await _sliderUseCase.call(
      SliderParams(
          cityCode: event.cityCode,
          mainCategoryCode: event.mainCategoryCode
      )
    );

    result.fold(
      (l) => emit(SliderFailureState(l.message)),
      (r) => emit(SliderSuccessState(r)),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE SliderBloc =====");
    return super.close();
  }
}
