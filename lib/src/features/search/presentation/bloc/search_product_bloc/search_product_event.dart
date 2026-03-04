part of 'search_product_bloc.dart';

sealed class SearchProductEvent extends Equatable {
  const SearchProductEvent();

  @override
  List<Object?> get props => [];
}

class SearchProductByKeywordEvent extends SearchProductEvent {
  final String keyword;
  final String offset;
  final String mainCategoryCode;
  final String cityCode;
  final String clientCode;

  const SearchProductByKeywordEvent({
    required this.keyword,
    required this.offset,
    required this.mainCategoryCode,
    required this.cityCode,
    required this.clientCode,
  });

  @override
  List<Object?> get props => [keyword, offset, mainCategoryCode, cityCode, clientCode];
}
