part of 'sign_in_bloc.dart';

/// Event for authentication related information.

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

/// Event for get otp.

class GetOtpEvent extends SignInEvent {
  final String contactNumber;
  final bool resend;

  const GetOtpEvent(this.contactNumber,this.resend);

  @override
  List<Object?> get props => [contactNumber,resend];
}

// /// Event for verify otp.
//
// class VerifyOtpEvent extends SignInEvent {
//   final String phone;
//   final String otp;
//
//   const VerifyOtpEvent(this.phone,this.otp);
//
//   @override
//   List<Object?> get props => [phone,otp];
// }
//
// /// Event to check login status.
//
// class AuthCheckSignInStatusEvent extends SignInEvent {}
//
// /// Event for logout.
//
// class AuthSignOutEvent extends SignInEvent {}
//
// /// Event to delete user account .
//
// class AccountDeleteGetEvent extends SignInEvent {
//
//   const AccountDeleteGetEvent();
//
//   @override
//   List<Object?> get props => [];
// }
