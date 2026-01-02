import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/core/errors/failures.dart';
import 'package:myvegiz_flutter/src/core/usecases/usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/common_response.dart';

import '../../../../remote/repositories/repository_impl.dart';

/// Domain layer use case for deleting user account, validates inputs and calls repository method.

class AccountDeleteUseCase implements UseCase<CommonResponse, AccountDeleteParams> {
  final Repository _authRepository;
  const AccountDeleteUseCase(this._authRepository);

  @override
  Future<Either<Failure, CommonResponse>> call(AccountDeleteParams params) async {

    final result = await _authRepository.account_delete(params);

    return result;
  }
}

class AccountDeleteParams extends Equatable {
  final String clientCode;

  const AccountDeleteParams({
    required this.clientCode,
  });

  @override
  List<Object?> get props => [
    clientCode,
  ];
}
