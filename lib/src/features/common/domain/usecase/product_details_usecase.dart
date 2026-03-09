import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/core/errors/failures.dart';
import 'package:myvegiz_flutter/src/core/usecases/usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/product_details_model/product_details_response.dart';
import 'package:myvegiz_flutter/src/remote/repositories/repository_impl.dart';

class GetProductDetailsUseCase
    implements UseCase<ProductDetailsResponse, ProductDetailsParams> {
  final Repository repository;

  GetProductDetailsUseCase(this.repository);

  @override
  Future<Either<Failure, ProductDetailsResponse>> call(
    ProductDetailsParams params,
  ) async {
    return await repository.productById(params);
  }
}

class ProductDetailsParams extends Equatable {
  final String productCode;
  final String mainCategoryCode;
  final String cityCode;
  final String clientCode;

  const ProductDetailsParams({
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
