import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/remote/models/home_slider_model/home_slider_response.dart';
import '../../../../configs/injector/injector.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

/// Domain layer use case for getting home slider images, validates inputs and calls repository method.

class HomeSliderUseCase implements UseCase<HomeSliderResponse, NoParams> {
  final Repository _authRepository;
  const HomeSliderUseCase(this._authRepository);

  @override
  Future<Either<Failure, HomeSliderResponse>> call(NoParams params) async {

    final result = await _authRepository.home_slider(params);

    return result;
  }
}
