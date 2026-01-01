import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';

class OrdersTabWidget extends StatefulWidget {
  const OrdersTabWidget({super.key});

  @override
  State<OrdersTabWidget> createState() => _OrdersTabWidgetState();
}

class _OrdersTabWidgetState extends State<OrdersTabWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: AppColor.white,
              child: TabBar(
                labelColor: AppColor.orangeDark,
                unselectedLabelColor: AppColor.black,
                indicatorColor: AppColor.orangeDark,
                tabs: [
                  Tab(text: "Vegetable/Grocery"),
                  Tab(text: "Restaurant"),
                ],
              ),
            ),
            SizedBox(
              height: 300,
              child: TabBarView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/empty_order_icon.png",
                        height: 150,
                        width: 150,
                      ),
                      8.hS,
                      Text(
                        'no_data_found'.tr(),
                        style: GoogleFonts.mavenPro(
                            color: AppColor.gray,fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/icons/empty_order_icon.png",
                        height: 150,
                        width: 150,
                      ),
                      8.hS,
                      Text(
                        'no_data_found'.tr(),
                        style: GoogleFonts.mavenPro(
                            color: AppColor.gray,fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        )
    );
  }
}
