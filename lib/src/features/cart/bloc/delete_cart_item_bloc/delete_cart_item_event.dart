part of 'delete_cart_item_bloc.dart';

sealed class DeleteCartItemEvent extends Equatable {
  const DeleteCartItemEvent();

  @override
  List<Object?> get props => [];
}

class DeleteCartItemSubmitEvent extends DeleteCartItemEvent {
  final DeleteCartItemParams params;

  const DeleteCartItemSubmitEvent(this.params);

  @override
  List<Object?> get props => [params];
}
