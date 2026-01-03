import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/remote/models/vegetable_slider_model/vegetable_slider_response.dart';
import '../../../../configs/injector/injector.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

/// Domain layer use case for getting vegetable slider images, validates inputs and calls repository method.

class VegetableSliderUseCase implements UseCase<VegetableSliderResponse, VegetableSliderParams> {
  final Repository _authRepository;
  const VegetableSliderUseCase(this._authRepository);

  @override
  Future<Either<Failure, VegetableSliderResponse>> call(VegetableSliderParams params) async {

    final result = await _authRepository.vegetable_slider(params);

    return result;
  }
}

class VegetableSliderParams extends Equatable {
  final String cityCode;
  final String mainCategoryCode;

  const VegetableSliderParams({
    required this.cityCode,
    required this.mainCategoryCode,
  });

  @override
  List<Object?> get props => [
    cityCode,
    mainCategoryCode,
  ];
}