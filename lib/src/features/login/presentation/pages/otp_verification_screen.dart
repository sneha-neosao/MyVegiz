import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/login/widgets/otp_input_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_button_widget.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              '+91-9876543214',
              style: GoogleFonts.mavenPro(
                  color: AppColor.black,fontSize: 14, fontWeight: FontWeight.w300),
            ),
            22.hS,
            OtpInputWidget(),
            22.hS,
            AppButtonWidget(
                onPressed: (){
                  context.pushNamed(AppRoute.otpVerificationScreen.name);
                },
                label: "verify".tr()
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
    );
  }
}
