part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  const SignInState();
  @override
  List<Object?> get props => [];
}

class AuthSigInInitialState extends SignInState {}

/// States like loading, success and failure representing get otp.

class GetOtpLoadingState extends SignInState {}

class GetOtpSuccessState extends SignInState {
  final GetOtpResponse data;

  const GetOtpSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class GetOtpFailureState extends SignInState {
  final String message;

  const GetOtpFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

/// States like loading, success and failure representing verify otp.

class VerifyOtpLoadingState extends SignInState {}

class VerifyOtpSuccessState extends SignInState {
  final OtpVerifyResponse data;

  const VerifyOtpSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class VerifyOtpFailureState extends SignInState {
  final String message;

  const VerifyOtpFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
//
// /// States like loading, success and failure representing login status.
//
// class AuthCheckSignInStatusLoadingState extends SignInState {}
//
// class AuthCheckSignInStatusSuccessState extends SignInState {
//   final MemberModel? userData;
//
//   const AuthCheckSignInStatusSuccessState(this.userData);
//
//   @override
//   List<Object?> get props => [userData];
// }
//
// class AuthCheckSignInStatusFailureState extends SignInState {
//   final String message;
//
//   const AuthCheckSignInStatusFailureState(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }
//
// /// States like loading, success and failure representing sign out.
//
// class AuthSignOutLoadingState extends SignInState {}
//
// class AuthSignOutSuccessState extends SignInState {
//   final String message;
//
//   const AuthSignOutSuccessState(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }
//
// class AuthSignOutFailureState extends SignInState {
//   final String message;
//
//   const AuthSignOutFailureState(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }
//
// /// States like loading, success and failure representing user account delete.
//
// class AccountDeleteLoadingState extends SignInState {}
//
// class AccountDeleteSuccessState extends SignInState {
//   final CommonResponse data;
//
//   const AccountDeleteSuccessState(this.data);
//
//   @override
//   List<Object?> get props => [data];
// }
//
// class AccountDeleteFailureState extends SignInState {
//   final String message;
//
//   const AccountDeleteFailureState(this.message);
//
//   @override
//   List<Object?> get props => [message];
// }
