part of 'registration_bloc.dart';

sealed class RegistrationState extends Equatable {
  const RegistrationState();
  @override
  List<Object?> get props => [];
}

/// States like loading, success and failure creating account.

class RegistrationLoadingState extends RegistrationState {}

class RegistrationSuccessState extends RegistrationState {
  final RegistrationResponse data;

  const RegistrationSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class RegistrationFailureState extends RegistrationState {
  final String message;

  const RegistrationFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
