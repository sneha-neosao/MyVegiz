part of 'category_bloc.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();
  @override
  List<Object?> get props => [];
}

class CategoryInitialState extends CategoryState {}

/// States like loading, success and failure representing category.

class CategoryLoadingState extends CategoryState {}

class CategorySuccessState extends CategoryState {
  final CategoryResponse data;

  const CategorySuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class CategoryFailureState extends CategoryState {
  final String message;

  const CategoryFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
