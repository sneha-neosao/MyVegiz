part of 'cartlist_bloc.dart';

/// Event for fetch cart list.

sealed class CartListEvent extends Equatable {
  const CartListEvent();

  @override
  List<Object?> get props => [];
}

/// Event for fetch cart list.

class CartListGetEvent extends CartListEvent {
  final String clientCode;

  const CartListGetEvent(this.clientCode,);

  @override
  List<Object?> get props => [clientCode];
}
