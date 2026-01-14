import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

class ConfirmLocationScreen extends StatefulWidget {
  const ConfirmLocationScreen({super.key});

  @override
  State<ConfirmLocationScreen> createState() => _ConfirmLocationScreenState();
}

class _ConfirmLocationScreenState extends State<ConfirmLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteShade,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: InkWell(
                            onTap: (){
                              context.pushNamed(AppRoute.selectLocationScreen.name);
                            },
                            child: Image.asset("assets/icons/back_arrow.png",height: 28, width: 28,)
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16)
                      )
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 26,
                              width: 26,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.orange.withOpacity(0.3)
                              ),
                              child: Center(
                                child: Image.asset(
                                  "assets/icons/location_filled_icon.png",
                                  color: AppColor.orangeDark,
                                  height: 18,
                                  width: 18,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: AppColor.orange.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 1.2,
                                  color: AppColor.darkGreen
                                )
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 2),
                                child: Text(
                                  'change'.tr(),
                                  style: GoogleFonts.mavenPro(
                                      color: AppColor.darkGreen,fontSize: 14, fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          ],
                        ),
                        40.hS,
                        Container(
                          height: 46,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                AppColor.startGreenButton,
                                AppColor.middleGreenButton,
                                AppColor.endGreenButton,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 6.0,horizontal: 30),
                              child: Text(
                                "confirm_location".tr(),
                                style: GoogleFonts.mavenPro(
                                  color: AppColor.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
          )
        ],
      )
    );
  }
}
