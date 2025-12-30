import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/features/login/domain/usecase/get_otp_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/auth_models/get_otp_response.dart';
import '../../../../core/utils/logger.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

/// Handles state management for **Auth Sign In** and its related entities.

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final GetOtpUseCase _getOtpUseCase;
  // final VerifyOtpUseCase _verifyOtpUseCase;
  // final DeleteAccountUseCase _deleteAccountUseCase;

  SignInBloc(
    this._getOtpUseCase,
    // this._verifyOtpUseCase,
    // this._deleteAccountUseCase
  ) : super(AuthSigInInitialState()) {
    on<GetOtpEvent>(_getOtp);
    // on<VerifyOtpEvent>(_verifyOtp);
    // on<AuthCheckSignInStatusEvent>(_checkSignInStatus);
    // on<AuthSignOutEvent>(_SignOut);
    // on<AccountDeleteGetEvent>(_accountDelete);
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

  // /// - **[_verifyOtp]:** Handles [VerifyOtpEvent] → calls [GetOtpUseCase]
  //
  // Future _verifyOtp(VerifyOtpEvent event, Emitter emit) async {
  //   emit(VerifyOtpLoadingState());
  //
  //   final result = await _verifyOtpUseCase.call(
  //     VerifyOtpParams(
  //       phone: event.phone,
  //       otp: event.otp
  //     ),
  //   );
  //
  //   result.fold(
  //         (l) => emit(VerifyOtpFailureState(l.message)),
  //         (r) => emit(VerifyOtpSuccessState(r)),
  //   );
  // }
  //
  // /// - **Check Sign-In Status:** Handles [AuthCheckSignInStatusEvent] → checks [SessionManager]
  // Future<Either<Failure, SignInResponse>> checkSignInStatus() async {
  //   try {
  //     final result = await SessionManager.isLoggedIn();
  //
  //     if(result==true) {
  //       final resultData = await SessionManager.getUserSessionInfo();
  //       return Right(resultData!);
  //     }
  //     return Left(CacheFailure(mapFailureToMessage(CacheFailure(""))));
  //   } on CacheException {
  //     return Left(CacheFailure(mapFailureToMessage(CacheFailure(""))));
  //   }
  // }
  //
  // Future _checkSignInStatus(AuthCheckSignInStatusEvent event, Emitter emit) async
  // {
  //   emit(AuthCheckSignInStatusLoadingState());
  //
  //   final result= await checkSignInStatus();
  //   result.fold(
  //         (l) => emit(AuthCheckSignInStatusFailureState(mapFailureToMessage(l))),
  //         (r) => emit(AuthCheckSignInStatusSuccessState(r.data)),
  //   );
  // }
  //
  // /// - **SignOut:** Handles [AuthSignOutEvent] → clears [SessionManager]
  // Future _SignOut(AuthSignOutEvent event, Emitter emit) async {
  //   emit(AuthSignOutLoadingState());
  //
  //   final result =  await SessionManager.clear();
  //
  //   result.fold(
  //         (l) => emit(AuthSignOutFailureState(mapFailureToMessage(l))),
  //         (r) => emit(const AuthSignOutSuccessState("SignOut Successfully")),
  //   );
  // }
  //
  // ///   - Delete user account
  // Future _accountDelete(AccountDeleteGetEvent event, Emitter emit) async {
  //   emit(AccountDeleteLoadingState());
  //
  //   final result = await _deleteAccountUseCase.call(
  //       NoParams()
  //   );
  //
  //   result.fold(
  //         (l) => emit(AccountDeleteFailureState(l.message)),
  //         (r) => emit(AccountDeleteSuccessState(r)),
  //   );
  // }

  @override
  Future<void> close() {
    logger.i("===== CLOSE SignInBloc =====");
    return super.close();
  }
}
