import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/remote/models/vegetable_slider_model/vegetable_category_response.dart';
import 'package:myvegiz_flutter/src/remote/models/vegetable_slider_model/vegetable_slider_response.dart';
import '../../../../configs/injector/injector.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

/// Domain layer use case for getting vegetable categories, validates inputs and calls repository method.

class VegetableCategoryUseCase implements UseCase<VegetableCategoryResponse, VegetableCategoryParams> {
  final Repository _authRepository;
  const VegetableCategoryUseCase(this._authRepository);

  @override
  Future<Either<Failure, VegetableCategoryResponse>> call(VegetableCategoryParams params) async {

    final result = await _authRepository.vegetable_category(params);

    return result;
  }
}

class VegetableCategoryParams extends Equatable {
  final String offset;
  final String mainCategoryCode;

  const VegetableCategoryParams({
    required this.offset,
    required this.mainCategoryCode,
  });

  @override
  List<Object?> get props => [
    offset,
    mainCategoryCode,
  ];
}