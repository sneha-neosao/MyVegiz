import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/remote/models/category_model/category_response.dart';
import '../../../../configs/injector/injector.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

/// Domain layer use case for getting vegetable categories, validates inputs and calls repository method.

class CategoryUseCase implements UseCase<CategoryResponse, CategoryParams> {
  final Repository _authRepository;
  const CategoryUseCase(this._authRepository);

  @override
  Future<Either<Failure, CategoryResponse>> call(CategoryParams params) async {

    final result = await _authRepository.category(params);

    return result;
  }
}

class CategoryParams extends Equatable {
  final String offset;
  final String mainCategoryCode;

  const CategoryParams({
    required this.offset,
    required this.mainCategoryCode,
  });

  @override
  List<Object?> get props => [
    offset,
    mainCategoryCode,
  ];
}