part of 'vegetable_slider_bloc.dart';

sealed class VegetableSliderState extends Equatable {
  const VegetableSliderState();
  @override
  List<Object?> get props => [];
}

class VegetableSliderInitialState extends VegetableSliderState {}

/// States like loading, success and failure representing vegetable slider image list.

class VegetableSliderLoadingState extends VegetableSliderState {}

class VegetableSliderSuccessState extends VegetableSliderState {
  final VegetableSliderResponse data;

  const VegetableSliderSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class VegetableSliderFailureState extends VegetableSliderState {
  final String message;

  const VegetableSliderFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
