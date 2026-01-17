import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/logger.dart';

part 'edit_profile_form_event.dart';
part 'edit_profile_form_state.dart';

/// Handles validation logic for **Edit Profile**.
class EditProfileFormBloc extends Bloc<EditProfileFormEvent, EditProfileFormState> {
  EditProfileFormBloc() : super(const EditProfileFormInitialState()) {
    on<EditProfileFormNameChangedEvent>(_nameChanged);
    on<EditProfileFormClientCodeChangedEvent>(_contactNumberChanged);
    on<EditProfileFormEmailChangedEvent>(_emailIdChanged);
    on<EditProfileFormCityCodeChangedEvent>(_cityCodeChanged);
  }

  /// - Listens to changes in registration name input
  Future _nameChanged(EditProfileFormNameChangedEvent event, Emitter emit) async {
    emit(
      EditProfileFormDataState(
        inputName: event.name,
        inputClientCode: state.clientCode,
        inputEmailId: state.emailId,
        inputCityCode: state.cityCode,
        inputIsValid: inputValidator(
          event.name,
          state.clientCode,
          state.emailId,
          state.cityCode
        ),
      ),
    );
  }

  /// - Listens to changes in registration client code input
  Future _contactNumberChanged(EditProfileFormClientCodeChangedEvent event, Emitter emit) async {
    emit(
      EditProfileFormDataState(
        inputName: state.name,
        inputClientCode: event.clientCode,
        inputEmailId: state.emailId,
        inputCityCode: state.cityCode,
        inputIsValid: inputValidator(
            state.name,
            event.clientCode,
            state.emailId,
            state.cityCode
        ),
      ),
    );
  }

  /// - Listens to changes in registration emailId input
  Future _emailIdChanged(EditProfileFormEmailChangedEvent event, Emitter emit) async {
    emit(
      EditProfileFormDataState(
        inputName: state.name,
        inputClientCode: state.clientCode,
        inputEmailId: event.emailId,
        inputCityCode: state.cityCode,
        inputIsValid: inputValidator(
            state.name,
            state.clientCode,
            event.emailId,
            state.cityCode
        ),
      ),
    );
  }

  /// - Listens to changes in registration cityCode input
  Future _cityCodeChanged(EditProfileFormCityCodeChangedEvent event, Emitter emit) async {
    emit(
      EditProfileFormDataState(
        inputName: state.name,
        inputClientCode: state.clientCode,
        inputEmailId: state.emailId,
        inputCityCode: event.cityCode,
        inputIsValid: inputValidator(
            state.name,
            state.clientCode,
            state.emailId,
            event.cityCode
        ),
      ),
    );
  }
  bool inputValidator(String name,String clientCode,String emailId,String cityCode) {
    if ( name.isNotEmpty && clientCode.isNotEmpty && emailId.isNotEmpty && cityCode.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE EditProfileFormBloc =====");
    return super.close();
  }
}
