part of 'category_and_product_bloc.dart';

sealed class CategoryAndProductState extends Equatable {
  const CategoryAndProductState();
  @override
  List<Object?> get props => [];
}

class CategoryAndProductInitialState extends CategoryAndProductState {}

/// States like loading, success and failure representing category and product.

class CategoryAndProductLoadingState extends CategoryAndProductState {}

class CategoryAndProductSuccessState extends CategoryAndProductState {
  final CategoryAndProductResponse data;

  const CategoryAndProductSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class CategoryAndProductFailureState extends CategoryAndProductState {
  final String message;

  const CategoryAndProductFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
