import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector_conf.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/login/widgets/otp_input_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_button_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_loading_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_snackbar_widget.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String contactNumber;

  const OtpVerificationScreen({super.key, required this.contactNumber});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  late SignInBloc _signInBloc;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? verificationId ;
  final TextEditingController otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _signInBloc = getIt<SignInBloc>();
    // _sendOtp();
  }

  void _sendOtp() async {
    await _auth.verifyPhoneNumber(
        phoneNumber: "+91${widget.contactNumber}",
        timeout: const Duration(seconds: 30),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          _verifyRegisterOtp();
        },
      verificationFailed: (FirebaseAuthException e) {
          appSnackBar(context, AppColor.brightRed, e.message ?? "Verification failed");
      },
        codeSent: (String verId, int? resendToken) {
          setState(() {
            verificationId = verId;   // assign to state variable
          });
          appSnackBar(context, AppColor.green, "otp_sent_successfully".tr());
      },
      codeAutoRetrievalTimeout: (String verId) {
        verificationId = verId;
      },
    );
  }

  void _verifyOtp(String otp) async {
    if (verificationId == null) {
      appSnackBar(context, AppColor.brightRed, "otp_not_sent_yet".tr());
    }

    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId!, smsCode: otp,
    );
    try {
      await _auth.signInWithCredential(credential);
      _verifyRegisterOtp();
    } catch (e) {
      appSnackBar(context, AppColor.brightRed, "invalid_otp".tr());
    }
  }

  void _verifyRegisterOtp() {
    // TODO: call your backend API (like verifyOtpProcess1 in Java)
    _signInBloc.add(VerifyOtpEvent(widget.contactNumber));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) =>_signInBloc)
      ],
      child: Scaffold(
        backgroundColor: AppColor.whiteShade,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'otp_verification'.tr(),
                style: GoogleFonts.mavenPro(
                    color: AppColor.black,fontSize: 20, fontWeight: FontWeight.bold),
              ),
              10.hS,
              Text(
                'we_have_sent_otp'.tr(),
                style: GoogleFonts.mavenPro(
                  color: AppColor.gray,
                  fontSize: 14,
                ),
              ),
              4.hS,
              Text(
                "+91-${widget.contactNumber}",
                style: GoogleFonts.mavenPro(
                    color: AppColor.black,fontSize: 14, fontWeight: FontWeight.w300),
              ),
              22.hS,
              OtpInputWidget(otpController: otpController,),
              22.hS,
              BlocConsumer<SignInBloc, SignInState>(
                listener: (_, state) {
                  if (state is VerifyOtpFailureState) {
                    appSnackBar(context, AppColor.brightRed, state.message);
                    if(state.message=="OTP Verified but User does not exists"){
                      context.pushNamed(AppRoute.registerScreen.name);
                    }
                  } else if (state is VerifyOtpSuccessState) {
                    appSnackBar(context, AppColor.green, state.data.message);
                    context.pushNamed(AppRoute.homeContentScreen.name);
                  }
                },
                builder: (context, state) {
                  if (state is VerifyOtpLoadingState) {
                    return Center(child: AppLoadingWidget());
                  }

                  return AppButtonWidget(
                    onPressed: (){
                      final otp = otpController.text.trim();
                      print("Entered OTP: $otp");
                      _verifyRegisterOtp();
                      // if (otp.length == 6) {
                      //   // _verifyOtp(otp);   // ✅ call Firebase with entered OTP
                      //   ;
                      // } else {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text("Enter valid OTP")),
                      //   );
                      // }
                    },
                    label: "verify".tr(),
                  );
                },
              ),
              30.hS,
              Center(
                child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'didnt_receive_code'.tr(),
                            style: GoogleFonts.mavenPro( color: AppColor.gray, fontSize: 14, )
                        ),
                        TextSpan(
                            text: 'resend'.tr(),
                            style: GoogleFonts.mavenPro( color: AppColor.orangeDark, fontSize: 14, )
                        )
                      ]
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
