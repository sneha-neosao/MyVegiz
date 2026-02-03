part of 'wishlist_bloc.dart';

/// Event for fetch wishlist.

sealed class WishListEvent extends Equatable {
  const WishListEvent();

  @override
  List<Object?> get props => [];
}

/// Event for fetch wishlist.

class WishListGetEvent extends WishListEvent {
  final String clientCode;
  final String mainCategoryCode;
  final String cityCode;

  const WishListGetEvent(this.clientCode, this.mainCategoryCode,this.cityCode);

  @override
  List<Object?> get props => [clientCode,mainCategoryCode,cityCode];
}
