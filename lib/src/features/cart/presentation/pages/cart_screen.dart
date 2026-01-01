import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteShade,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Image.asset("assets/icons/empty_cart_icon.png")),
          12.hS,
          Text(
            'your_cart_is_empty'.tr(),
            style: GoogleFonts.mavenPro(
                color: AppColor.gray,fontSize: 18, fontWeight: FontWeight.bold),
          ),
          4.hS,
          Text(
            'add_products_to_cart_now'.tr(),
            style: GoogleFonts.mavenPro(
                color: AppColor.black,fontSize: 14, fontWeight: FontWeight.normal),
          ),
          16.hS,
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.colorPrimary,
              ),
              onPressed: (){
                context.pushNamed(AppRoute.homeContentScreen.name);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Text(
                  'shop_now'.tr(),
                  style: GoogleFonts.mavenPro(
                      color: AppColor.white,fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
          )
        ],
      )
    );
  }
}
