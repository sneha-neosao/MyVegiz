part of 'registration_bloc.dart';

/// Event for authentication related information.

sealed class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object?> get props => [];
}

/// Event for registration.

class RegistrationGetEvent extends RegistrationEvent {
  final String name;
  final String contactNumber;
  final String emailId;
  final String cityCode;

  const RegistrationGetEvent(this.name,this.contactNumber,this.emailId,this.cityCode);

  @override
  List<Object?> get props => [name,contactNumber,emailId,cityCode];
}
