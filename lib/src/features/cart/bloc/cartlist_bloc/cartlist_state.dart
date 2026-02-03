part of 'cartlist_bloc.dart';

sealed class CartListState extends Equatable {
  const CartListState();
  @override
  List<Object?> get props => [];
}

class CartListInitialState extends CartListState {}

/// States like loading, success and failure fetching cart list .

class CartListLoadingState extends CartListState {}

class CartListSuccessState extends CartListState {
  final CartListResponse data;

  const CartListSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class CartListFailureState extends CartListState {
  final String message;

  const CartListFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
