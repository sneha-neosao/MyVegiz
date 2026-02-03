import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/remote/models/common_response.dart';
import '../../../../configs/injector/injector.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

/// Domain layer use case for adding product to wishlist, validates inputs and calls repository method.

class AddToWishListUseCase implements UseCase<CommonResponse, AddToWishListParams> {
  final Repository _authRepository;
  const AddToWishListUseCase(this._authRepository);

  @override
  Future<Either<Failure, CommonResponse>> call(AddToWishListParams params) async {

    final result = await _authRepository.add_to_wish_list(params);

    return result;
  }
}

class AddToWishListParams extends Equatable {
  final String productCode;
  final String clientCode;

  const AddToWishListParams({
    required this.productCode,
    required this.clientCode,
  });

  @override
  List<Object?> get props => [
    productCode,
    clientCode,
  ];
}