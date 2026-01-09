part of 'category_and_product_bloc.dart';

/// Event for category and product.

sealed class CategoryAndProductEvent extends Equatable {
  const CategoryAndProductEvent();

  @override
  List<Object?> get props => [];
}

/// Event for category.

class CategoryAndProductGetEvent extends CategoryAndProductEvent {
  final String cityCode;
  final String offset;
  final String mainCategoryCode;

  const CategoryAndProductGetEvent(this.offset, this.mainCategoryCode, this.cityCode);

  @override
  List<Object?> get props => [cityCode,offset, mainCategoryCode];
}
