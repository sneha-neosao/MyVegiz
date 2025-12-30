import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/core/extensions/string_validator_extension.dart';
import 'package:myvegiz_flutter/src/remote/models/auth_models/get_otp_response.dart';
import '../../../../configs/injector/injector.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

/// Domain layer use case for getting otp to signing in into account, validates inputs and calls repository method.

class GetOtpUseCase implements UseCase<GetOtpResponse, GetOtpParams> {
  final Repository _authRepository;
  const GetOtpUseCase(this._authRepository);

  @override
  Future<Either<Failure, GetOtpResponse>> call(GetOtpParams params) async {

    if (params.contactNumber.isEmpty) {
      return Left(EmptyFailure("please_enter_mobile_number".tr()));
    }

    if (!params.contactNumber.isMobileNumberValid) {
      return Left(EmptyFailure("invalid_mobile_number".tr()));
    }

    final result = await _authRepository.get_otp(params);

    return result;
  }
}

class GetOtpParams extends Equatable {
  final String contactNumber;
  final bool resend;

  const GetOtpParams({
    required this.contactNumber,
    required this.resend,
  });

  @override
  List<Object?> get props => [
    contactNumber,
    resend,
  ];
}
