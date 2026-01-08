part of 'vegetable_category_bloc.dart';

sealed class VegetableCategoryState extends Equatable {
  const VegetableCategoryState();
  @override
  List<Object?> get props => [];
}

class VegetableCategoryInitialState extends VegetableCategoryState {}

/// States like loading, success and failure representing vegetable category.

class VegetableCategoryLoadingState extends VegetableCategoryState {}

class VegetableCategorySuccessState extends VegetableCategoryState {
  final VegetableCategoryResponse data;

  const VegetableCategorySuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class VegetableCategoryFailureState extends VegetableCategoryState {
  final String message;

  const VegetableCategoryFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
