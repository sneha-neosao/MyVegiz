part of 'slider_bloc.dart';

sealed class SliderState extends Equatable {
  const SliderState();
  @override
  List<Object?> get props => [];
}

class SliderInitialState extends SliderState {}

/// States like loading, success and failure representing slider image list.

class SliderLoadingState extends SliderState {}

class SliderSuccessState extends SliderState {
  final SliderResponse data;

  const SliderSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class SliderFailureState extends SliderState {
  final String message;

  const SliderFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
