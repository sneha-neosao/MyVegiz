part of 'get_otp_form_bloc.dart';

/// Base state for Get Otp validation Bloc.
///
/// Holds the current form data in [inputs] and a validation flag [isValid].

sealed class GetOtpFormState extends Equatable
{
  final String phone;
  final bool resend;
  final bool isValid;

  const GetOtpFormState({
    required this.phone,
    required this.resend,
    required this.isValid,
  });

  @override
  List<Object?> get props => [
        phone,
        resend,
        isValid,
      ];
}

/// Provides a default empty [inputs] with [isValid] set to false.

class GetOtpFormInitialState extends GetOtpFormState {
  const GetOtpFormInitialState()
      : super(
          phone: "",
          resend: false,
          isValid: false,
        );
}

/// State representing the current validated data after an input change.
///
/// Carries the updated [inputs] and a boolean [inputIsValid] indicating
/// if the current input passes validation.

class GetOtpFormDataState extends GetOtpFormState {
  final String inputPhone;
  final bool inputResend;
  final bool inputIsValid;

  const GetOtpFormDataState({
    required this.inputPhone,
    required this.inputResend,
    required this.inputIsValid,
  }) : super(
          phone: inputPhone,
          resend: inputResend,
          isValid: inputIsValid,
        );

  @override
  List<Object?> get props => [
        inputPhone,
        inputResend,
        inputIsValid,
      ];
}
