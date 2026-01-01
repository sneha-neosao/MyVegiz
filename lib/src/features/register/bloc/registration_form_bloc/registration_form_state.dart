part of 'registration_form_bloc.dart';

/// Base state for Get Otp validation Bloc.
///
/// Holds the current form data in [inputs] and a validation flag [isValid].

sealed class RegistrationFormState extends Equatable
{
  final String name;
  final String contactNumber;
  final String emailId;
  final String cityCode;
  final bool isValid;

  const RegistrationFormState({
    required this.name,
    required this.contactNumber,
    required this.emailId,
    required this.cityCode,
    required this.isValid,
  });

  @override
  List<Object?> get props => [
        name,
        contactNumber,
        emailId,
        cityCode,
        isValid,
      ];
}

/// Provides a default empty [inputs] with [isValid] set to false.

class RegistrationFormInitialState extends RegistrationFormState {
  const RegistrationFormInitialState()
      : super(
          name: "",
          contactNumber: "",
          emailId: "",
          cityCode: "",
          isValid: false,
        );
}

/// State representing the current validated data after an input change.
///
/// Carries the updated [inputs] and a boolean [inputIsValid] indicating
/// if the current input passes validation.

class RegistrationFormDataState extends RegistrationFormState {
  final String inputName;
  final String inputContactNumber;
  final String inputEmailId;
  final String inputCityCode;
  final bool inputIsValid;

  const RegistrationFormDataState({
    required this.inputName,
    required this.inputContactNumber,
    required this.inputEmailId,
    required this.inputCityCode,
    required this.inputIsValid,
  }) : super(
          name: inputName,
          contactNumber: inputContactNumber,
          emailId: inputEmailId,
          cityCode: inputCityCode,
          isValid: inputIsValid,
        );

  @override
  List<Object?> get props => [
        inputName,
        inputContactNumber,
        inputEmailId,
        inputCityCode,
        inputIsValid,
      ];
}
