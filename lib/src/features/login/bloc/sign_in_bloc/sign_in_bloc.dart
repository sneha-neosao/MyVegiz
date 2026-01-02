import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/core/errors/exceptions.dart';
import 'package:myvegiz_flutter/src/core/errors/failures.dart';
import 'package:myvegiz_flutter/src/core/session/session_manager.dart';
import 'package:myvegiz_flutter/src/core/utils/failure_converter.dart';
import 'package:myvegiz_flutter/src/features/login/domain/usecase/get_otp_usecase.dart';
import 'package:myvegiz_flutter/src/features/login/domain/usecase/verify_otp_usecase.dart';
import 'package:myvegiz_flutter/src/features/myAccount/domain/usecase/account_delete_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/auth_models/get_otp_response.dart';
import 'package:myvegiz_flutter/src/remote/models/auth_models/otp_verify_response.dart';
import 'package:myvegiz_flutter/src/remote/models/common_response.dart';
import 'package:myvegiz_flutter/src/remote/models/user_model/user_model.dart';
import '../../../../core/utils/logger.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

/// Handles state management for **Auth Sign In** and its related entities.

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final GetOtpUseCase _getOtpUseCase;
  final VerifyOtpUseCase _verifyOtpUseCase;
  final AccountDeleteUseCase _accountDeleteUseCase;

  SignInBloc(
    this._getOtpUseCase,
    this._verifyOtpUseCase,
    this._accountDeleteUseCase
  ) : super(AuthSigInInitialState()) {
    on<GetOtpEvent>(_getOtp);
    on<VerifyOtpEvent>(_verifyOtp);
    on<AuthCheckLoginStatusEvent>(_checkSignInStatus);
    on<AuthLogOutEvent>(_logOut);
    on<AccountDeleteGetEvent>(_accountDelete);
  }

  /// - **[_getotp]:** Handles [GetOtpEvent] → calls [GetOtpUseCase]

  Future _getOtp(GetOtpEvent event, Emitter emit) async {
    emit(GetOtpLoadingState());

    final result = await _getOtpUseCase.call(
      GetOtpParams(
        contactNumber: event.contactNumber,
        resend: event.resend
      ),
    );

    result.fold(
      (l) => emit(GetOtpFailureState(l.message)),
      (r) => emit(GetOtpSuccessState(r)),
    );
  }

  /// - **[_verifyOtp]:** Handles [VerifyOtpEvent] → calls [GetOtpUseCase]

  Future _verifyOtp(VerifyOtpEvent event, Emitter emit) async {
    emit(VerifyOtpLoadingState());

    final result = await _verifyOtpUseCase.call(
      VerifyOtpParams(
        contactNumber: event.contactNumber,
      ),
    );

    result.fold(
          (l) => emit(VerifyOtpFailureState(l.message)),
          (r) => emit(VerifyOtpSuccessState(r)),
    );
  }

  /// - **Check Sign-In Status:** Handles [AuthCheckLoginStatusEvent] → checks [SessionManager]
  Future<Either<Failure, UserModel>> checkSignInStatus() async {
    try {
      final result = await SessionManager.isLoggedIn();

      if(result==true) {
        final resultData = await SessionManager.getUserSessionInfo();
        return Right(resultData!);
      }
      return Left(CacheFailure(mapFailureToMessage(CacheFailure(""))));
    } on CacheException {
      return Left(CacheFailure(mapFailureToMessage(CacheFailure(""))));
    }
  }

  Future _checkSignInStatus(AuthCheckLoginStatusEvent event, Emitter emit) async
  {
    emit(AuthCheckLoginStatusLoadingState());

    final result= await checkSignInStatus();
    result.fold(
          (l) => emit(AuthCheckLoginStatusFailureState(mapFailureToMessage(l))),
          (r) => emit(AuthCheckLoginStatusSuccessState(r)),
    );
  }

  /// - **SignOut:** Handles [AuthLogOutEvent] → clears [SessionManager]
  Future _logOut(AuthLogOutEvent event, Emitter emit) async {
    emit(AuthLogOutLoadingState());

    final result =  await SessionManager.clear();

    result.fold(
          (l) => emit(AuthLogOutFailureState(mapFailureToMessage(l))),
          (r) => emit(AuthLogOutSuccessState("logout_successfully".tr())),
    );
  }

  ///   - Delete user account
  Future _accountDelete(AccountDeleteGetEvent event, Emitter emit) async {
    emit(AccountDeleteLoadingState());

    final result = await _accountDeleteUseCase.call(
        AccountDeleteParams(
            clientCode: event.clientCode
        )
    );

    result.fold(
          (l) => emit(AccountDeleteFailureState(l.message)),
          (r) => emit(AccountDeleteSuccessState(r)),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE SignInBloc =====");
    return super.close();
  }
}
