part of 'home_slider_bloc.dart';

sealed class HomeSliderState extends Equatable {
  const HomeSliderState();
  @override
  List<Object?> get props => [];
}

class HomeSliderInitialState extends HomeSliderState {}

/// States like loading, success and failure representing home slider image list.

class HomeSliderLoadingState extends HomeSliderState {}

class HomeSliderSuccessState extends HomeSliderState {
  final HomeSliderResponse data;

  const HomeSliderSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class HomeSliderFailureState extends HomeSliderState {
  final String message;

  const HomeSliderFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
