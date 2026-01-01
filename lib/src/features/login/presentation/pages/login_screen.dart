import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/login/widgets/login_input_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_button_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_loading_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_snackbar_widget.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

import '../../../../configs/injector/injector.dart';
import '../../../../configs/injector/injector_conf.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String enteredPhone = '';

  /// Handles the login action by dispatching an event to the AuthLoginBloc.
  void _getOtp(BuildContext context) {
    primaryFocus?.unfocus();
    final authForm = context.read<GetOtpFormBloc>().state;
    enteredPhone = authForm.phone.trim(); // 👈 STORE HERE

    context.read<SignInBloc>().add(
      GetOtpEvent(authForm.phone.trim(), false),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<GetOtpFormBloc>()),
        BlocProvider(create: (_) => getIt<SignInBloc>())
      ],
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(
              'assets/images/login_bg.png',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.whiteShade,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  8.hS,
                  Transform.translate(
                    offset: Offset(0, 10),
                    child: Image.asset(
                      'assets/images/appicon.png',
                      fit: BoxFit.fill,
                      width: 25,
                      height: 40,
                    ),
                  ),
                  Image.asset(
                    'assets/images/myvegiztext.png',
                    width: 95,
                  ),
                  Text(
                    'log_in_or_sign_up'.tr(),
                    style: GoogleFonts.mavenPro(
                        color: AppColor.black,fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  6.hS,
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 26.0),
                    child: Text(
                      'credential_note'.tr(),
                      style: GoogleFonts.mavenPro(
                        color: AppColor.gray,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  16.hS,
                  LoginInputWidget(),
                  16.hS,
                  BlocConsumer<SignInBloc, SignInState>(
                    listener: (_, state) {
                      if (state is GetOtpLoadingState) {
                        AppLoadingWidget();
                      } else if (state is GetOtpFailureState) {
                        appSnackBar(context, AppColor.brightRed, state.message);
                      } else if (state is GetOtpSuccessState) {
                        appSnackBar(context, AppColor.green, state.data.message);
                        context.pushNamed(AppRoute.otpVerificationScreen.name,extra: enteredPhone);
                      }
                    },
                    builder: (context, state) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: AppButtonWidget(
                            onPressed: (){
                              _getOtp(context);
                              // FirebaseOtpService.sendOtp();
                            },
                            label: "continue".tr()
                        ),
                      );
                    },
                  ),
                  35.hS
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
