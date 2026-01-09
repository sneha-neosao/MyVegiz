import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/remote/models/slider_model/slider_response.dart';
import '../../../../configs/injector/injector.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

/// Domain layer use case for getting vegetable slider images, validates inputs and calls repository method.

class SliderUseCase implements UseCase<SliderResponse, SliderParams> {
  final Repository _authRepository;
  const SliderUseCase(this._authRepository);

  @override
  Future<Either<Failure, SliderResponse>> call(SliderParams params) async {

    final result = await _authRepository.slider(params);

    return result;
  }
}

class SliderParams extends Equatable {
  final String cityCode;
  final String mainCategoryCode;

  const SliderParams({
    required this.cityCode,
    required this.mainCategoryCode,
  });

  @override
  List<Object?> get props => [
    cityCode,
    mainCategoryCode,
  ];
}