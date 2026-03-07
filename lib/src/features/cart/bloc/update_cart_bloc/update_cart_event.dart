part of 'update_cart_bloc.dart';

sealed class UpdateCartEvent extends Equatable {
  const UpdateCartEvent();

  @override
  List<Object> get props => [];
}

class UpdateCartQunatyEvent extends UpdateCartEvent {
  final UpdateCartParams params;

  const UpdateCartQunatyEvent(this.params);

  @override
  List<Object> get props => [params];
}
