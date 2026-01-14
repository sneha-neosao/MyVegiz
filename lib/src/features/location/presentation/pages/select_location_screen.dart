import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/widgets/search_text_field_widget.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteShade,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: (){
                        context.goNamed(AppRoute.homeContentScreen.name);
                      },
                      child: Image.asset("assets/icons/back_arrow.png",height: 28, width: 28,)
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 48,
                      child: SearchTextField(
                          hint: "search_location_here".tr(),
                          onChanged: (value){}
                      ),
                    ),
                  )
                ],
              ),
              12.hS,
              InkWell(
                onTap: (){
                  context.pushNamed(AppRoute.confirmLocationScreen.name);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.my_location_sharp, size: 18, color: AppColor.orange,
                          ),
                          8.wS,
                          Text(
                            'current_location'.tr(),
                            style: GoogleFonts.mavenPro(
                                color: AppColor.orange,fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    1.hS,
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 34.0),
                      child: Text(
                        'using_gps'.tr(),
                        style: GoogleFonts.mavenPro(
                            color: AppColor.hintText,fontSize: 14, fontWeight: FontWeight.normal),
                      ),
                    ),
                    12.hS,
                    Container(
                      height: 1,
                      color: AppColor.hintText.withOpacity(0.6),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
