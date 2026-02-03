part of 'wishlist_bloc.dart';

sealed class WishListState extends Equatable {
  const WishListState();
  @override
  List<Object?> get props => [];
}

class WishListInitialState extends WishListState {}

/// States like loading, success and failure fetching wishlist.

class WishListLoadingState extends WishListState {}

class WishListSuccessState extends WishListState {
  final WishlistResponse data;

  const WishListSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class WishListFailureState extends WishListState {
  final String message;

  const WishListFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
