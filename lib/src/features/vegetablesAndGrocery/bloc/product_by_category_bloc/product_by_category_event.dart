part of 'product_by_category_bloc.dart';

/// Event for product by category.

sealed class ProductByCategoryEvent extends Equatable {
  const ProductByCategoryEvent();

  @override
  List<Object?> get props => [];
}

/// Event for product by category.

class ProductByCategoryGetEvent extends ProductByCategoryEvent {
  final String offset;
  final String mainCategoryCode;
  final String cityCode;
  final String categorySName;

  const ProductByCategoryGetEvent(this.offset, this.mainCategoryCode, this.cityCode, this.categorySName);

  @override
  List<Object?> get props => [offset, mainCategoryCode, cityCode, categorySName];
}
