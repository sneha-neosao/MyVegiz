import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/logger.dart';

part 'get_otp_form_event.dart';
part 'get_otp_form_state.dart';

/// Handles validation logic for **get otp**.
class GetOtpFormBloc extends Bloc<GetOtpFormEvent, GetOtpFormState> {
  GetOtpFormBloc() : super(const GetOtpFormInitialState()) {
    on<GetOtpFormPhoneChangedEvent>(_phoneChanged);
    on<GetOtpFormResendChangedEvent>(_resendChanged);
  }

  /// - Listens to changes in get otp phone input
  Future _phoneChanged(GetOtpFormPhoneChangedEvent event, Emitter emit) async {
    emit(
      GetOtpFormDataState(
        inputPhone: event.phone,
        inputResend: state.resend,
        inputIsValid: inputValidator(
          event.phone,
          state.resend,
        ),
      ),
    );
  }

  /// - Listens to changes in get otp resend input
  Future _resendChanged(GetOtpFormResendChangedEvent event, Emitter emit) async {
    emit(
      GetOtpFormDataState(
        inputPhone: state.phone,
        inputResend: event.resend,
        inputIsValid: inputValidator(
          state.phone,
          event.resend,
        ),
      ),
    );
  }

  bool inputValidator(String phone,bool resend) {
    if ( phone.isNotEmpty && resend.toString().isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Future<void> close() {
    logger.i("===== CLOSE GetOtpFormBloc =====");
    return super.close();
  }
}
