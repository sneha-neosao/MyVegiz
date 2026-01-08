part of 'vegetable_category_bloc.dart';

/// Event for vegetable category.

sealed class VegetableCategoryEvent extends Equatable {
  const VegetableCategoryEvent();

  @override
  List<Object?> get props => [];
}

/// Event for vegetable category.

class VegetableCategoryGetEvent extends VegetableCategoryEvent {
  final String offset;
  final String mainCategoryCode;

  const VegetableCategoryGetEvent(this.offset, this.mainCategoryCode);

  @override
  List<Object?> get props => [offset, mainCategoryCode];
}
