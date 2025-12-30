import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector.dart';
import 'package:myvegiz_flutter/src/features/login/widgets/login_text_field_widget.dart';

/// Widget for login input fields (company code, email, password)
class LoginInputWidget extends StatefulWidget {
  const LoginInputWidget({super.key});

  @override
  State<LoginInputWidget> createState() => _LoginInputWidgetState();
}

class _LoginInputWidgetState extends State<LoginInputWidget> {
  late GetOtpFormBloc formBloc;

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<GetOtpFormBloc>();

    return Column(
      children: [
        LoginTextField<GetOtpFormBloc>(
          label: "mobile_number".tr(),
          hint: "enter_mobile_number".tr(),
          onChanged: (val) {
            print("number entered: ${val}");
            formBloc.add(GetOtpFormPhoneChangedEvent(val));
          },
          keyboardType: TextInputType.phone,
        ),
      ],
    );
  }
}
