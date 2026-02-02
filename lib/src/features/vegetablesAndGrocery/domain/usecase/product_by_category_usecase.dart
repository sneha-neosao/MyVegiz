import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/remote/models/category_and_product_model/category_and_product_response.dart';
import 'package:myvegiz_flutter/src/remote/models/category_by_product_model/category_by_product_response.dart';
import '../../../../configs/injector/injector.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

/// Domain layer use case for getting products by category, validates inputs and calls repository method.

class ProductByCategoryUseCase implements UseCase<ProductByCategoryResponse, ProductByCategoryParams> {
  final Repository _authRepository;
  const ProductByCategoryUseCase(this._authRepository);

  @override
  Future<Either<Failure, ProductByCategoryResponse>> call(ProductByCategoryParams params) async {

    final result = await _authRepository.product_by_category(params);

    return result;
  }
}

class ProductByCategoryParams extends Equatable {
  final String offset;
  final String mainCategoryCode;
  final String cityCode;
  final String categorySName;

  const ProductByCategoryParams({
    required this.offset,
    required this.mainCategoryCode,
    required this.cityCode,
    required this.categorySName
  });

  @override
  List<Object?> get props => [
    offset,
    mainCategoryCode,
    cityCode,
    categorySName
  ];
}