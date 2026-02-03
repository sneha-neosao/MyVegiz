import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/core/errors/failures.dart';
import 'package:myvegiz_flutter/src/core/usecases/usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/common_response.dart';
import 'package:myvegiz_flutter/src/remote/models/wish_list_model/wish_list_response.dart';

import '../../../../remote/repositories/repository_impl.dart';

/// Domain layer use case for fetching wish list, validates inputs and calls repository method.

class WishListUseCase implements UseCase<WishlistResponse, WishListParams> {
  final Repository _authRepository;
  const WishListUseCase(this._authRepository);

  @override
  Future<Either<Failure, WishlistResponse>> call(WishListParams params) async {

    final result = await _authRepository.wish_list(params);

    return result;
  }
}

class WishListParams extends Equatable {
  final String clientCode;
  final String mainCategoryCode;
  final String cityCode;

  const WishListParams({
    required this.clientCode,
    required this.mainCategoryCode,
    required this.cityCode
  });

  @override
  List<Object?> get props => [
    clientCode,
    mainCategoryCode,
    cityCode
  ];
}
