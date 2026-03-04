part of 'add_to_cart_bloc.dart';

sealed class AddToCartState extends Equatable {
  const AddToCartState();

  @override
  List<Object?> get props => [];
}

class AddToCartInitial extends AddToCartState {}

class AddToCartLoading extends AddToCartState {}

class AddToCartSuccess extends AddToCartState {
  final CommonResponse response;

  const AddToCartSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class AddToCartFailure extends AddToCartState {
  final String message;

  const AddToCartFailure(this.message);

  @override
  List<Object?> get props => [message];
}
