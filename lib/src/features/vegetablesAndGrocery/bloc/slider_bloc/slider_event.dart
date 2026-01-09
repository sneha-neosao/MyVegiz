part of 'slider_bloc.dart';

/// Event for slider image list.

sealed class SliderEvent extends Equatable {
  const SliderEvent();

  @override
  List<Object?> get props => [];
}

/// Event for slider image list.

class SliderGetEvent extends SliderEvent {
  final String cityCode;
  final String mainCategoryCode;

  const SliderGetEvent(this.cityCode, this.mainCategoryCode);

  @override
  List<Object?> get props => [cityCode, mainCategoryCode];
}
