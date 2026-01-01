part of 'city_list_bloc.dart';

sealed class CityListState extends Equatable {
  const CityListState();
  @override
  List<Object?> get props => [];
}

class CityListInitialState extends CityListState {}

/// States like loading, success and failure representing city list.

class CityListLoadingState extends CityListState {}

class CityListSuccessState extends CityListState {
  final CityListResponse data;

  const CityListSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class CityListFailureState extends CityListState {
  final String message;

  const CityListFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
