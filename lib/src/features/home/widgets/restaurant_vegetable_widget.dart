import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

class RestaurantVegetableWidget extends StatelessWidget {
  const RestaurantVegetableWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Image.asset("assets/icons/restaurant_image.png"),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'restaurant'.tr(),
                      style: GoogleFonts.mavenPro(
                          color: AppColor.white,fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'view_all'.tr(),
                          style: GoogleFonts.mavenPro(
                              color: AppColor.orange,fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        4.wS,
                        Image.asset("assets/icons/view_arrow.png"),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          14.hS,
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Image.asset("assets/icons/vegetables_image.png"),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'vegetables_and_grocery'.tr(),
                      style: GoogleFonts.mavenPro(
                          color: AppColor.black,fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                      onTap: (){
                        context.pushNamed(AppRoute.vegetablesAndGroceryScreen.name);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'view_all'.tr(),
                            style: GoogleFonts.mavenPro(
                                color: AppColor.orange,fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          4.wS,
                          Image.asset("assets/icons/view_arrow.png"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
