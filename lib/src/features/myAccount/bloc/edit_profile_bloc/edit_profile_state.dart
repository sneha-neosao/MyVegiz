part of 'edit_profile_bloc.dart';

sealed class EditProfileState extends Equatable {
  const EditProfileState();
  @override
  List<Object?> get props => [];
}

/// States like loading, success and failure updating profile.
class EditProfileInitialState extends EditProfileState {}

class EditProfileLoadingState extends EditProfileState {}

class EditProfileSuccessState extends EditProfileState {
  final CommonResponse data;

  const EditProfileSuccessState(this.data);

  @override
  List<Object?> get props => [data];
}

class EditProfileFailureState extends EditProfileState {
  final String message;

  const EditProfileFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
