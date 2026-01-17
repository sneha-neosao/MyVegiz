import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/core/errors/failures.dart';
import 'package:myvegiz_flutter/src/core/extensions/string_validator_extension.dart';
import 'package:myvegiz_flutter/src/core/usecases/usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/common_response.dart';

import '../../../../remote/repositories/repository_impl.dart';

/// Domain layer use case for updating user account, validates inputs and calls repository method.

class EditProfileUseCase implements UseCase<CommonResponse, EditProfileParams> {
  final Repository _authRepository;
  const EditProfileUseCase(this._authRepository);

  @override
  Future<Either<Failure, CommonResponse>> call(EditProfileParams params) async {


    if (params.name.isEmpty) {
      return Left(EmptyFailure("please_enter_name".tr()));
    }

    if (params.emailId.isEmpty) {
      return Left(EmptyFailure("please_enter_email".tr()));
    }

    if (!params.emailId.isEmailValid) {
      return Left(EmptyFailure("please_enter_valid_email".tr()));
    }

    if (params.cityCode.isEmpty) {
      return Left(EmptyFailure("please_select_city".tr()));
    }

    final result = await _authRepository.edit_profile(params);

    return result;
  }
}

class EditProfileParams extends Equatable {
  final String clientCode;
  final String name;
  final String emailId;
  final String cityCode;

  const EditProfileParams({
    required this.clientCode,
    required this.name,
    required this.emailId,
    required this.cityCode
  });

  @override
  List<Object?> get props => [
    clientCode,
    name,
    emailId,
    cityCode
  ];
}
