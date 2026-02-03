import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/core/errors/failures.dart';
import 'package:myvegiz_flutter/src/core/usecases/usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/cart_model/cart_list_response.dart';
import '../../../remote/repositories/repository_impl.dart';

/// Domain layer use case for fetching cart list, validates inputs and calls repository method.

class CartListUseCase implements UseCase<CartListResponse, CartListParams> {
  final Repository _authRepository;
  const CartListUseCase(this._authRepository);

  @override
  Future<Either<Failure, CartListResponse>> call(CartListParams params) async {

    final result = await _authRepository.cart_list(params);

    return result;
  }
}

class CartListParams extends Equatable {
  final String clientCode;

  const CartListParams({
    required this.clientCode,
  });

  @override
  List<Object?> get props => [
    clientCode,
  ];
}
