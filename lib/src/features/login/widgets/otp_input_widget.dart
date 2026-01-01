import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:pinput/pinput.dart';
import '../../../configs/injector/injector.dart';

class OtpInputWidget extends StatelessWidget {
  final TextEditingController otpController;

  const OtpInputWidget({super.key, required this.otpController});

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      keyboardType: TextInputType.number,
      controller: otpController,

      /// update OTP in BLoC
      onChanged: (value) {
        // context.read<VerifyOtpFormBloc>().add(
        //   VerifyOtpFormOtpChangedEvent(value),
        // );
      },

      /// on OTP completed
      onCompleted: (value) {
        // context.read<VerifyOtpFormBloc>().add(
        //   VerifyOtpFormOtpChangedEvent(value),
        // );
      },

      defaultPinTheme: PinTheme(
        width: 56,
        height: 51,
        textStyle: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(fontWeight: FontWeight.w600, fontSize: 17,color: AppColor.black),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
