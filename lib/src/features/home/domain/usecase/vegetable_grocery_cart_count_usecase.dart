import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/core/errors/failures.dart';
import 'package:myvegiz_flutter/src/core/usecases/usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/cart_model/cart_count_response.dart';
import 'package:myvegiz_flutter/src/remote/models/common_response.dart';

import '../../../../remote/repositories/repository_impl.dart';

/// Domain layer use case for vegetable and grocery cart count, validates inputs and calls repository method.

class VegetableGroceryCartCountUseCase implements UseCase<CartCountResponse, VegetableGroceryCartCountParams> {
  final Repository _authRepository;
  const VegetableGroceryCartCountUseCase(this._authRepository);

  @override
  Future<Either<Failure, CartCountResponse>> call(VegetableGroceryCartCountParams params) async {

    final result = await _authRepository.cart_count(params);

    return result;
  }
}

class VegetableGroceryCartCountParams extends Equatable {
  final String clientCode;

  const VegetableGroceryCartCountParams({
    required this.clientCode,
  });

  @override
  List<Object?> get props => [
    clientCode,
  ];
}
