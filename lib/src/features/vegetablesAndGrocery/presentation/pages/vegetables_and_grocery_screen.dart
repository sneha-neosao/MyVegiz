import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/widgets/grocery_tab_widget.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/widgets/vegetable_category_list_widgte.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/widgets/vegetable_slider_selection_widget.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/widgets/vegetable_tab_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/vegetable_category_shimmer_widget.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../configs/injector/injector_conf.dart';
import '../../../widgets/app_snackbar_widget.dart';

class VegetablesAndGroceryScreen extends StatefulWidget {
  final String cityCode;

  const VegetablesAndGroceryScreen({super.key, required this.cityCode});

  @override
  State<VegetablesAndGroceryScreen> createState() =>
      _VegetablesAndGroceryScreenState();
}

class _VegetablesAndGroceryScreenState extends State<VegetablesAndGroceryScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteShade,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          context.goNamed(AppRoute.homeContentScreen.name);
                        },
                        child: Image.asset(
                          "assets/icons/back_arrow.png",
                          height: 28,
                          width: 28,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'vegetables_and_grocery'.tr(),
                        style: GoogleFonts.mavenPro(
                          color: AppColor.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      const SizedBox(height: 28, width: 28),
                    ],
                  ),
                  20.hS,
                ],
              ),
            ),

            /// 🔥 THIS Expanded FIXES EVERYTHING
            Expanded(
              child: DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: AppColor.gray.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: PreferredSize(
                            preferredSize: Size.fromHeight(10),
                            child: TabBar(
                              dividerColor: Colors.transparent,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    AppColor.startOrangeButton,
                                    AppColor.middleOrangeButton,
                                    AppColor.endOrangeButton,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelColor: AppColor.white,
                              unselectedLabelColor: AppColor.gray,
                              // indicatorPadding: const EdgeInsets.symmetric(horizontal: 4),
                              tabs: const [
                                Tab(
                                  child: SizedBox(
                                    child: Center(child: Text("Vegetable")),
                                  ),
                                ),
                                Tab(
                                  child: SizedBox(
                                    child: Center(child: Text("Grocery")),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    /// ✅ Now TabBarView gets bounded height
                    Expanded(
                      child: TabBarView(
                        children: [
                          VegetableTabWidget(cityCode: widget.cityCode,),
                          // _emptyState(
                          //   text: "No Vegetables Available".tr(),
                          // ),
                          GroceryTabWidget(cityCode: widget.cityCode,)
                          // _emptyState(
                          //   text: "No Grocery Available".tr(),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          color: AppColor.white,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "1 Items",
                      style: GoogleFonts.mavenPro(
                          color: AppColor.black,fontSize: 14, fontWeight: FontWeight.w600
                      ),
                    ),
                    Text(
                      "₹40.00",
                      style: GoogleFonts.mavenPro(
                          color: AppColor.black,fontSize: 18, fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
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
                        "View Cart",
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
      ),
    );
  }

  Widget _emptyState({required String text}) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/icons/empty_order_icon.png",
            height: 150,
            width: 150,
          ),
          8.hS,
          Text(
            text,
            style: GoogleFonts.mavenPro(
              color: AppColor.gray,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

}
