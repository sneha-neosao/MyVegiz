part of 'add_to_wishlist_bloc.dart';

sealed class AddToWishListState extends Equatable {
  const AddToWishListState();
  @override
  List<Object?> get props => [];
}

class AddToWishListInitialState extends AddToWishListState {}

/// States like loading, success and failure adding product to wishlist.

class AddToWishListLoadingState extends AddToWishListState {}

class AddToWishListSuccessState extends AddToWishListState {
  final CommonResponse data;

  const AddToWishListSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class AddToWishListFailureState extends AddToWishListState {
  final String message;

  const AddToWishListFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
