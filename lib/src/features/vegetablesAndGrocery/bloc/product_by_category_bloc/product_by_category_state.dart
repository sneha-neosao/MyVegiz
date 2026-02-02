part of 'product_by_category_bloc.dart';

sealed class ProductByCategoryState extends Equatable {
  const ProductByCategoryState();
  @override
  List<Object?> get props => [];
}

class ProductByCategoryInitialState extends ProductByCategoryState {}

/// States like loading, success and failure representing product by category.

class ProductByCategoryLoadingState extends ProductByCategoryState {}

class ProductByCategorySuccessState extends ProductByCategoryState {
  final ProductByCategoryResponse data;

  const ProductByCategorySuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class ProductByCategoryFailureState extends ProductByCategoryState {
  final String message;

  const ProductByCategoryFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
