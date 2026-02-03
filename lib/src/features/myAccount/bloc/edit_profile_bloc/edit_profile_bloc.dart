import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/features/login/domain/usecase/get_otp_usecase.dart';
import 'package:myvegiz_flutter/src/features/myAccount/domain/usecase/edit_profile_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/common_response.dart';
import '../../../../core/utils/logger.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

/// Handles state management for **Edit Profile** and its related entities.

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final EditProfileUseCase _editProfileUseCase;

  EditProfileBloc(
    this._editProfileUseCase,
  ) : super(EditProfileInitialState()) {
    on<EditProfileGetEvent>(_editProfile);
  }

  /// - **[_editProfile]:** Handles [EditProfileGetEvent] → calls [GetOtpUseCase]

  Future _editProfile(EditProfileGetEvent event, Emitter emit) async {
    emit(EditProfileInitialState());

    final result = await _editProfileUseCase.call(
      EditProfileParams(
        clientCode: event.clientCode,
        name: event.name,
        emailId: event.emailId,
        cityCode: event.cityCode
      ),
    );

    result.fold(
      (l) => emit(EditProfileFailureState(l.message)),
      (r) => emit(EditProfileSuccessState(r)),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE EditProfileBloc =====");
    return super.close();
  }
}
