part of 'edit_profile_bloc.dart';

/// Event for updating profile information.

sealed class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

/// Event for Edit profile.

class EditProfileGetEvent extends EditProfileEvent {
  final String clientCode;
  final String name;
  final String emailId;
  final String cityCode;

  const EditProfileGetEvent(this.clientCode,this.name,this.emailId,this.cityCode);

  @override
  List<Object?> get props => [clientCode,name,emailId,cityCode];
}
