import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/core/usecases/usecase.dart';
import 'package:myvegiz_flutter/src/features/home/domain/usecase/home_slider_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/home_slider_model/home_slider_response.dart';
import '../../../../core/utils/logger.dart';

part 'home_slider_event.dart';
part 'home_slider_state.dart';

/// Handles state management for **Slider Image List Get** and its related entities.

class HomeSliderBloc extends Bloc<HomeSliderEvent, HomeSliderState> {
  final HomeSliderUseCase _homeSliderUseCase;

  HomeSliderBloc(
    this._homeSliderUseCase,
  ) : super(HomeSliderInitialState()) {
    on<HomeSliderGetEvent>(_homeSlider);
  }

  /// - **[_homeSlider]:** Handles [HomeSliderGetEvent] → calls [HomeSliderUseCase]

  Future _homeSlider(HomeSliderGetEvent event, Emitter emit) async {
    emit(HomeSliderLoadingState());

    final result = await _homeSliderUseCase.call(
      NoParams()
    );

    result.fold(
      (l) => emit(HomeSliderFailureState(l.message)),
      (r) => emit(HomeSliderSuccessState(r)),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE HomeSliderBloc =====");
    return super.close();
  }
}
