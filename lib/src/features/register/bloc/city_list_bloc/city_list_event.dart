part of 'city_list_bloc.dart';

/// Event for city list.

sealed class CityListEvent extends Equatable {
  const CityListEvent();

  @override
  List<Object?> get props => [];
}

/// Event for city list.

class CityListGetEvent extends CityListEvent {

  const CityListGetEvent();

  @override
  List<Object?> get props => [];
}
