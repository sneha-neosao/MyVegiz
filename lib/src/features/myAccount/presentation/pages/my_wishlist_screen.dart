import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/myAccount/widgets/edit_profile_input_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_button_widget.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

class MyWishListScreen extends StatefulWidget {
  const MyWishListScreen({super.key});

  @override
  State<MyWishListScreen> createState() => _MyWishListScreenState();
}

class _MyWishListScreenState extends State<MyWishListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteShade,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: (){
                      context.goNamed(AppRoute.myAccountScreen.name);
                    },
                      child: Image.asset("assets/icons/back_arrow.png",height: 28, width: 28,)
                  ),
                  Spacer(),
                  Text(
                    'wishlist'.tr(),
                    style: GoogleFonts.mavenPro(
                        color: AppColor.black,fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  SizedBox(height: 28,width: 28,)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
