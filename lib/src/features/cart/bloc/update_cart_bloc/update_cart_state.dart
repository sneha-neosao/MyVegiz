part of 'update_cart_bloc.dart';

sealed class UpdateCartState extends Equatable {
  const UpdateCartState();

  @override
  List<Object?> get props => [];
}

class UpdateCartInitial extends UpdateCartState {}

class UpdateCartLoading extends UpdateCartState {}

class UpdateCartSuccess extends UpdateCartState {
  final CommonResponse response;

  const UpdateCartSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class UpdateCartFailure extends UpdateCartState {
  final String message;

  const UpdateCartFailure(this.message);

  @override
  List<Object?> get props => [message];
}
