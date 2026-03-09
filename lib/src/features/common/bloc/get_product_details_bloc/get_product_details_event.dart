part of 'get_product_details_bloc.dart';

sealed class GetProductDetailsEvent extends Equatable {
  const GetProductDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchProductDetailsEvent extends GetProductDetailsEvent {
  final String productCode;
  final String mainCategoryCode;
  final String cityCode;
  final String clientCode;

  const FetchProductDetailsEvent({
    required this.productCode,
    required this.mainCategoryCode,
    required this.cityCode,
    required this.clientCode,
  });

  @override
  List<Object> get props => [
    productCode,
    mainCategoryCode,
    cityCode,
    clientCode,
  ];
}
