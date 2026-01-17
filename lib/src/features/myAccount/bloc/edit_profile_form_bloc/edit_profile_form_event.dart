part of 'edit_profile_form_bloc.dart';

/// Base class for all events related to Get Otp Validation Bloc.
/// Extends [Equatable] to support value comparison, which helps BLoC
/// determine whether state updates are necessary.

sealed class EditProfileFormEvent extends Equatable {
  const EditProfileFormEvent();

  @override
  List<Object?> get props => [];
}

/// listens for change in name input
class EditProfileFormNameChangedEvent extends EditProfileFormEvent {
  final String name;

  const EditProfileFormNameChangedEvent(this.name);

  @override
  List<Object?> get props => [name];
}

/// listens for change in client code input

class EditProfileFormClientCodeChangedEvent extends EditProfileFormEvent {
  final String clientCode;

  const EditProfileFormClientCodeChangedEvent(this.clientCode);

  @override
  List<Object?> get props => [clientCode];
}

/// listens for change in email input
class EditProfileFormEmailChangedEvent extends EditProfileFormEvent {
  final String emailId;

  const EditProfileFormEmailChangedEvent(this.emailId);

  @override
  List<Object?> get props => [emailId];
}

/// listens for change in city input

class EditProfileFormCityCodeChangedEvent extends EditProfileFormEvent {
  final String cityCode;

  const EditProfileFormCityCodeChangedEvent(this.cityCode);

  @override
  List<Object?> get props => [cityCode];
}