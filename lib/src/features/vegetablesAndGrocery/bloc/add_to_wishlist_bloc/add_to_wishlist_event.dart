part of 'add_to_wishlist_bloc.dart';

/// Event for add product in wishlist.

sealed class AddToWishListEvent extends Equatable {
  const AddToWishListEvent();

  @override
  List<Object?> get props => [];
}

/// Event for add product in wishlist.

class AddToWishListGetEvent extends AddToWishListEvent {
  final String productCode;
  final String clientCode;

  const AddToWishListGetEvent(this.productCode, this.clientCode);

  @override
  List<Object?> get props => [productCode, clientCode];
}
