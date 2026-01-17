part of 'edit_profile_form_bloc.dart';

/// Base state for Update Profile validation Bloc.
///
/// Holds the current form data in [inputs] and a validation flag [isValid].

sealed class EditProfileFormState extends Equatable
{
  final String name;
  final String clientCode;
  final String emailId;
  final String cityCode;
  final bool isValid;

  const EditProfileFormState({
    required this.name,
    required this.clientCode,
    required this.emailId,
    required this.cityCode,
    required this.isValid,
  });

  @override
  List<Object?> get props => [
        name,
        clientCode,
        emailId,
        cityCode,
        isValid,
      ];
}

/// Provides a default empty [inputs] with [isValid] set to false.

class EditProfileFormInitialState extends EditProfileFormState {
  const EditProfileFormInitialState()
      : super(
          name: "",
          clientCode: "",
          emailId: "",
          cityCode: "",
          isValid: false,
        );
}

/// State representing the current validated data after an input change.
///
/// Carries the updated [inputs] and a boolean [inputIsValid] indicating
/// if the current input passes validation.

class EditProfileFormDataState extends EditProfileFormState {
  final String inputName;
  final String inputClientCode;
  final String inputEmailId;
  final String inputCityCode;
  final bool inputIsValid;

  const EditProfileFormDataState({
    required this.inputName,
    required this.inputClientCode,
    required this.inputEmailId,
    required this.inputCityCode,
    required this.inputIsValid,
  }) : super(
          name: inputName,
          clientCode: inputClientCode,
          emailId: inputEmailId,
          cityCode: inputCityCode,
          isValid: inputIsValid,
        );

  @override
  List<Object?> get props => [
        inputName,
        inputClientCode,
        inputEmailId,
        inputCityCode,
        inputIsValid,
      ];
}
