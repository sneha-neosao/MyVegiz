import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/remote/models/auth_models/get_otp_response.dart';
import 'package:myvegiz_flutter/src/remote/models/auth_models/otp_verify_response.dart';
import '../../../../configs/injector/injector.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

/// Domain layer use case for getting otp to signing in into account, validates inputs and calls repository method.

class VerifyOtpUseCase implements UseCase<OtpVerifyResponse, VerifyOtpParams> {
  final Repository _authRepository;
  const VerifyOtpUseCase(this._authRepository);

  @override
  Future<Either<Failure, OtpVerifyResponse>> call(VerifyOtpParams params) async {

    final result = await _authRepository.verify_otp(params);

    return result;
  }
}

class VerifyOtpParams extends Equatable {
  final String contactNumber;

  const VerifyOtpParams({
    required this.contactNumber,
  });

  @override
  List<Object?> get props => [
    contactNumber,
  ];
}
