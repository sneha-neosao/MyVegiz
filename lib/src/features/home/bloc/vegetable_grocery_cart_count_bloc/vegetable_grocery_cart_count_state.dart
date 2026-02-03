part of 'vegetable_grocery_cart_count_bloc.dart';

sealed class VegetableGroceryCartCountState extends Equatable {
  const VegetableGroceryCartCountState();
  @override
  List<Object?> get props => [];
}

class VegetableGroceryCartCountInitialState extends VegetableGroceryCartCountState {}

/// States like loading, success and failure fetching vegetable grocery cart count.

class VegetableGroceryCartCountLoadingState extends VegetableGroceryCartCountState {}

class VegetableGroceryCartCountSuccessState extends VegetableGroceryCartCountState {
  final CartCountResponse data;

  const VegetableGroceryCartCountSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class VegetableGroceryCartCountFailureState extends VegetableGroceryCartCountState {
  final String message;

  const VegetableGroceryCartCountFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
