part of 'registration_form_bloc.dart';

/// Base class for all events related to Get Otp Validation Bloc.
/// Extends [Equatable] to support value comparison, which helps BLoC
/// determine whether state updates are necessary.

sealed class RegistrationFormEvent extends Equatable {
  const RegistrationFormEvent();

  @override
  List<Object?> get props => [];
}

/// listens for change in name input
class RegistrationFormNameChangedEvent extends RegistrationFormEvent {
  final String name;

  const RegistrationFormNameChangedEvent(this.name);

  @override
  List<Object?> get props => [name];
}

/// listens for change in phone input

class RegistrationFormContactNumberChangedEvent extends RegistrationFormEvent {
  final String contactNumber;

  const RegistrationFormContactNumberChangedEvent(this.contactNumber);

  @override
  List<Object?> get props => [contactNumber];
}

/// listens for change in email input
class RegistrationFormEmailChangedEvent extends RegistrationFormEvent {
  final String emailId;

  const RegistrationFormEmailChangedEvent(this.emailId);

  @override
  List<Object?> get props => [emailId];
}

/// listens for change in city input

class RegistrationFormCityCodeChangedEvent extends RegistrationFormEvent {
  final String cityCode;

  const RegistrationFormCityCodeChangedEvent(this.cityCode);

  @override
  List<Object?> get props => [cityCode];
}