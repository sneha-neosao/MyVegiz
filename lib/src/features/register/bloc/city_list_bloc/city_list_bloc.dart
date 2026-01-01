import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/core/usecases/usecase.dart';
import 'package:myvegiz_flutter/src/features/home/domain/usecase/home_slider_usecase.dart';
import 'package:myvegiz_flutter/src/features/register/domain/usecase/city_list_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/city_model/city_list_response.dart';
import 'package:myvegiz_flutter/src/remote/models/home_slider_model/home_slider_response.dart';
import '../../../../core/utils/logger.dart';

part 'city_list_event.dart';
part 'city_list_state.dart';

/// Handles state management for **City List Get** and its related entities.

class CityListBloc extends Bloc<CityListEvent, CityListState> {
  final CityListUseCase _cityListUseCase;

  CityListBloc(
    this._cityListUseCase,
  ) : super(CityListInitialState()) {
    on<CityListGetEvent>(_cityList);
  }

  /// - **[_cityList]:** Handles [CityListGetEvent] → calls [HomeSliderUseCase]

  Future _cityList(CityListGetEvent event, Emitter emit) async {
    emit(CityListLoadingState());

    final result = await _cityListUseCase.call(
      NoParams()
    );

    result.fold(
      (l) => emit(CityListFailureState(l.message)),
      (r) => emit(CityListSuccessState(r)),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE CityListBloc =====");
    return super.close();
  }
}
