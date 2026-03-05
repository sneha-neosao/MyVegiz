import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/core/errors/failures.dart';
import 'package:myvegiz_flutter/src/core/usecases/usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/common_response.dart';

import '../../../remote/repositories/repository_impl.dart';

class DeleteCartItemUseCase
    extends UseCase<CommonResponse, DeleteCartItemParams> {
  final Repository _repository;

  DeleteCartItemUseCase(this._repository);

  @override
  Future<Either<Failure, CommonResponse>> call(
    DeleteCartItemParams params,
  ) async {
    return await _repository.deleteCartItem(params);
  }
}

class DeleteCartItemParams extends Equatable {
  final String clientCode;

  const DeleteCartItemParams({required this.clientCode});

  @override
  List<Object?> get props => [clientCode];
}
