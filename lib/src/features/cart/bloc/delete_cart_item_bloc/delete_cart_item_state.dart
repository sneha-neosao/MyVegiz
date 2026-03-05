part of 'delete_cart_item_bloc.dart';

sealed class DeleteCartItemState extends Equatable {
  const DeleteCartItemState();

  @override
  List<Object?> get props => [];
}

class DeleteCartItemInitial extends DeleteCartItemState {}

class DeleteCartItemLoading extends DeleteCartItemState {}

class DeleteCartItemSuccess extends DeleteCartItemState {
  final CommonResponse response;

  const DeleteCartItemSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class DeleteCartItemFailure extends DeleteCartItemState {
  final String message;

  const DeleteCartItemFailure(this.message);

  @override
  List<Object?> get props => [message];
}
