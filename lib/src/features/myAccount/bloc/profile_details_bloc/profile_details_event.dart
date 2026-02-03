part of 'profile_details_bloc.dart';

/// Event for fetch profile details.

sealed class ProfileDetailsEvent extends Equatable {
  const ProfileDetailsEvent();

  @override
  List<Object?> get props => [];
}

/// Event for fetch profile details.

class ProfileDetailsGetEvent extends ProfileDetailsEvent {
  final String clientCode;

  const ProfileDetailsGetEvent(this.clientCode,);

  @override
  List<Object?> get props => [clientCode];
}
