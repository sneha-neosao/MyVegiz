part of 'vegetable_slider_bloc.dart';

/// Event for vegetable slider image list.

sealed class VegetableSliderEvent extends Equatable {
  const VegetableSliderEvent();

  @override
  List<Object?> get props => [];
}

/// Event for vegetable slider image list.

class VegetableSliderGetEvent extends VegetableSliderEvent {
  final String cityCode;
  final String mainCategoryCode;

  const VegetableSliderGetEvent(this.cityCode, this.mainCategoryCode);

  @override
  List<Object?> get props => [cityCode, mainCategoryCode];
}
