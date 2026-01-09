part of 'category_bloc.dart';

/// Event for category.

sealed class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

/// Event for category.

class CategoryGetEvent extends CategoryEvent {
  final String offset;
  final String mainCategoryCode;

  const CategoryGetEvent(this.offset, this.mainCategoryCode);

  @override
  List<Object?> get props => [offset, mainCategoryCode];
}
