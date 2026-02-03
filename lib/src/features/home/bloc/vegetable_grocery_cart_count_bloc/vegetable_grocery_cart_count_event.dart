part of 'vegetable_grocery_cart_count_bloc.dart';

/// Event for fetch cart count.

sealed class CartCountEvent extends Equatable {
  const CartCountEvent();

  @override
  List<Object?> get props => [];
}

/// Event for fetch cart count.

class CartCountGetEvent extends CartCountEvent {
  final String clientCode;

  const CartCountGetEvent(this.clientCode,);

  @override
  List<Object?> get props => [clientCode,];
}
