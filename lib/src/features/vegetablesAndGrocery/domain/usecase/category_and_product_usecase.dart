import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/remote/models/category_and_product_model/category_and_product_response.dart';
import '../../../../configs/injector/injector.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

/// Domain layer use case for getting categories and products, validates inputs and calls repository method.

class CategoryAndProductUseCase implements UseCase<CategoryAndProductResponse, CategoryAndProductParams> {
  final Repository _authRepository;
  const CategoryAndProductUseCase(this._authRepository);

  @override
  Future<Either<Failure, CategoryAndProductResponse>> call(CategoryAndProductParams params) async {

    final result = await _authRepository.category_and_product(params);

    return result;
  }
}

class CategoryAndProductParams extends Equatable {
  final String cityCode;
  final String offset;
  final String mainCategoryCode;

  const CategoryAndProductParams({
    required this.cityCode,
    required this.offset,
    required this.mainCategoryCode,
  });

  @override
  List<Object?> get props => [
    cityCode,
    offset,
    mainCategoryCode,
  ];
}