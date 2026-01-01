import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/core/extensions/string_validator_extension.dart';
import 'package:myvegiz_flutter/src/remote/models/auth_models/get_otp_response.dart';
import 'package:myvegiz_flutter/src/remote/models/registration_model/registration_response.dart';
import '../../../../configs/injector/injector.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

/// Domain layer use case for creating account, validates inputs and calls repository method.

class RegistrationUseCase implements UseCase<RegistrationResponse, RegistrationParams> {
  final Repository _authRepository;
  const RegistrationUseCase(this._authRepository);

  @override
  Future<Either<Failure, RegistrationResponse>> call(RegistrationParams params) async {

    if (params.name.isEmpty) {
      return Left(EmptyFailure("please_enter_mobile_number".tr()));
    }

    if (params.contactNumber.isEmpty) {
      return Left(EmptyFailure("please_enter_mobile_number".tr()));
    }

    if (!params.contactNumber.isMobileNumberValid) {
      return Left(EmptyFailure("invalid_mobile_number".tr()));
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

    final result = await _authRepository.registration(params);

    return result;
  }
}

class RegistrationParams extends Equatable {
  final String name;
  final String contactNumber;
  final String emailId;
  final String cityCode;

  const RegistrationParams({
    required this.name,
    required this.contactNumber,
    required this.emailId,
    required this.cityCode,
  });

  @override
  List<Object?> get props => [
    name,
    contactNumber,
    emailId,
    cityCode,
  ];
}
