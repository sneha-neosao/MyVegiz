import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/core/errors/failures.dart';
import 'package:myvegiz_flutter/src/core/usecases/usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/city_model/city_list_response.dart';

import '../../../../remote/repositories/repository_impl.dart';

/// Domain layer use case for getting city list, validates inputs and calls repository method.

class CityListUseCase implements UseCase<CityListResponse, NoParams> {
  final Repository _authRepository;
  const CityListUseCase(this._authRepository);

  @override
  Future<Either<Failure, CityListResponse>> call(NoParams params) async {

    final result = await _authRepository.city_list(params);

    return result;
  }
}
