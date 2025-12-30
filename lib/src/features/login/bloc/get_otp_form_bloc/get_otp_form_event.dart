part of 'get_otp_form_bloc.dart';

/// Base class for all events related to Get Otp Validation Bloc.
/// Extends [Equatable] to support value comparison, which helps BLoC
/// determine whether state updates are necessary.

sealed class GetOtpFormEvent extends Equatable {
  const GetOtpFormEvent();

  @override
  List<Object?> get props => [];
}

/// listens for change in phone input
class GetOtpFormPhoneChangedEvent extends GetOtpFormEvent {
  final String phone;

  const GetOtpFormPhoneChangedEvent(this.phone);

  @override
  List<Object?> get props => [phone];
}

/// listens for change in resend or not input

class GetOtpFormResendChangedEvent extends GetOtpFormEvent {
  final bool resend;

  const GetOtpFormResendChangedEvent(this.resend);

  @override
  List<Object?> get props => [resend];
}
