import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:myvegiz_flutter/src/features/login/domain/usecase/get_otp_usecase.dart';
import 'package:myvegiz_flutter/src/features/login/domain/usecase/verify_otp_usecase.dart';
import 'package:myvegiz_flutter/src/features/register/domain/usecase/registeration_usecase.dart';
import 'package:myvegiz_flutter/src/remote/models/auth_models/get_otp_response.dart';
import 'package:myvegiz_flutter/src/remote/models/auth_models/otp_verify_response.dart';
import 'package:myvegiz_flutter/src/remote/models/registration_model/registration_response.dart';
import '../../../../core/utils/logger.dart';

part 'registration_event.dart';
part 'registration_state.dart';

/// Handles state management for **Registration** and its related entities.

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final RegistrationUseCase _registrationUseCase;

  RegistrationBloc(
    this._registrationUseCase,
  ) : super(RegistrationLoadingState()) {
    on<RegistrationGetEvent>(_registration);
  }

  /// - **[_registration]:** Handles [RegistrationGetEvent] → calls [GetOtpUseCase]

  Future _registration(RegistrationGetEvent event, Emitter emit) async {
    emit(RegistrationLoadingState());

    final result = await _registrationUseCase.call(
      RegistrationParams(
        name: event.name,
        contactNumber: event.contactNumber,
        emailId: event.emailId,
        cityCode: event.cityCode
      ),
    );

    result.fold(
      (l) => emit(RegistrationFailureState(l.message)),
      (r) => emit(RegistrationSuccessState(r)),
    );
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE RegistrationBloc =====");
    return super.close();
  }
}
