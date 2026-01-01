import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/logger.dart';

part 'registration_form_event.dart';
part 'registration_form_state.dart';

/// Handles validation logic for **Registration**.
class RegistrationFormBloc extends Bloc<RegistrationFormEvent, RegistrationFormState> {
  RegistrationFormBloc() : super(const RegistrationFormInitialState()) {
    on<RegistrationFormNameChangedEvent>(_nameChanged);
    on<RegistrationFormContactNumberChangedEvent>(_contactNumberChanged);
    on<RegistrationFormEmailChangedEvent>(_emailIdChanged);
    on<RegistrationFormCityCodeChangedEvent>(_cityCodeChanged);
  }

  /// - Listens to changes in registration name input
  Future _nameChanged(RegistrationFormNameChangedEvent event, Emitter emit) async {
    emit(
      RegistrationFormDataState(
        inputName: event.name,
        inputContactNumber: state.contactNumber,
        inputEmailId: state.emailId,
        inputCityCode: state.cityCode,
        inputIsValid: inputValidator(
          event.name,
          state.contactNumber,
          state.emailId,
          state.cityCode
        ),
      ),
    );
  }

  /// - Listens to changes in registration contactNumber input
  Future _contactNumberChanged(RegistrationFormContactNumberChangedEvent event, Emitter emit) async {
    emit(
      RegistrationFormDataState(
        inputName: state.name,
        inputContactNumber: event.contactNumber,
        inputEmailId: state.emailId,
        inputCityCode: state.cityCode,
        inputIsValid: inputValidator(
            state.name,
            event.contactNumber,
            state.emailId,
            state.cityCode
        ),
      ),
    );
  }

  /// - Listens to changes in registration emailId input
  Future _emailIdChanged(RegistrationFormEmailChangedEvent event, Emitter emit) async {
    emit(
      RegistrationFormDataState(
        inputName: state.name,
        inputContactNumber: state.contactNumber,
        inputEmailId: event.emailId,
        inputCityCode: state.cityCode,
        inputIsValid: inputValidator(
            state.name,
            state.contactNumber,
            event.emailId,
            state.cityCode
        ),
      ),
    );
  }

  /// - Listens to changes in registration cityCode input
  Future _cityCodeChanged(RegistrationFormCityCodeChangedEvent event, Emitter emit) async {
    emit(
      RegistrationFormDataState(
        inputName: state.name,
        inputContactNumber: state.contactNumber,
        inputEmailId: state.emailId,
        inputCityCode: event.cityCode,
        inputIsValid: inputValidator(
            state.name,
            state.contactNumber,
            state.emailId,
            event.cityCode
        ),
      ),
    );
  }
  bool inputValidator(String name,String contactNumber,String emailId,String cityCode) {
    if ( name.isNotEmpty && contactNumber.isNotEmpty && emailId.isNotEmpty && cityCode.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE RegistrationFormBloc =====");
    return super.close();
  }
}
