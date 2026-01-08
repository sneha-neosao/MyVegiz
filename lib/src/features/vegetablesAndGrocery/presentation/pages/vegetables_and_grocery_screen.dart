import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/widgets/vegetable_category_list_widgte.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/widgets/vegetable_slider_selection_widget.dart';
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
  late VegetableSliderBloc _vegetableSliderBloc;
  late VegetableCategoryBloc _vegetableCategoryBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vegetableSliderBloc = getIt<VegetableSliderBloc>()..add(VegetableSliderGetEvent(widget.cityCode, "MCAT_1"));
    _vegetableCategoryBloc = getIt<VegetableCategoryBloc>()..add(VegetableCategoryGetEvent("0", "MCAT_1"));
  }
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _vegetableSliderBloc),
        BlocProvider(create: (_) => _vegetableCategoryBloc)
      ],
      child: Scaffold(
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
                            padding: const EdgeInsets.all(8.0),
                            child: TabBar(
                              dividerColor: Colors.transparent,
                              indicatorSize: TabBarIndicatorSize.tab,
                              indicator: BoxDecoration(
                                color: AppColor.orangeDark,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              labelColor: AppColor.white,
                              unselectedLabelColor: AppColor.gray,
                              indicatorPadding:
                              const EdgeInsets.symmetric(horizontal: 4),
                              tabs: const [
                                Tab(
                                  child: SizedBox(
                                    height: 36,
                                    child: Center(child: Text("Vegetable")),
                                  ),
                                ),
                                Tab(
                                  child: SizedBox(
                                    height: 36,
                                    child: Center(child: Text("Grocery")),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
      
                      /// ✅ Now TabBarView gets bounded height
                      Expanded(
                        child: TabBarView(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14.0,vertical: 14),
                              child: Column(
                                crossAxisAlignment : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'vegetables_fruits'.tr(),
                                    style: GoogleFonts.mavenPro(
                                        color: AppColor.black,fontSize: 24, fontWeight: FontWeight.bold),
                                  ),
                                  16.hS,
                                  BlocConsumer<VegetableSliderBloc, VegetableSliderState>(
                                    listener: (context, state) {
                                      if (state is VegetableSliderFailureState) {
                                        appSnackBar(context, AppColor.brightRed, state.message);
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is VegetableSliderLoadingState) {
                                        return Column(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 14.0),
                                              child: Shimmer.fromColors(
                                                baseColor: Colors.grey[400]!,
                                                highlightColor: Colors.grey[50]!,
                                                child: Container(
                                                  height: 186,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(13),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else if (state is VegetableSliderSuccessState) {
                                        final result = state.data.result;

                                        if (result == null || result.sliderImages.isEmpty) {
                                          return Center(
                                            child: Text(
                                              'no_matching_data_found'.tr(),
                                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                                color: Colors.grey,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          );
                                        }

                                        // Convert List<HomeSliderImage> → List<String>
                                        final bannerUrls = result.sliderImages.map((e) => e.imagePath).toList();
                                        return VegetableBannerCarouselSection(bannerUrls: bannerUrls);
                                      }
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                  22.hS,
                                  BlocConsumer<VegetableCategoryBloc, VegetableCategoryState>(
                                      listener: (context, state) {
                                        if (state is VegetableCategoryFailureState) {
                                          appSnackBar(context, AppColor.brightRed, state.message);
                                        }
                                      },
                                      builder: (context, state) {
                                        if (state is VegetableCategoryLoadingState) {
                                          return SizedBox(
                                            height: 200.h,
                                            child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              // padding: EdgeInsets.symmetric(horizontal: 6.w),
                                              itemCount: 6, // number of shimmer placeholders
                                              itemBuilder: (_, __) => const VegetableCategoryShimmerWidget(),
                                              separatorBuilder: (_, __) => SizedBox(width: 8.w), // same spacing as your listview
                                            ),
                                          );
                                        } else if (state is VegetableCategorySuccessState) {
                                          final vegetableCategoryList = state.data;
                                          
                                          if (vegetableCategoryList.result.categories.isEmpty) {
                                            return Container(
                                              height: 30,
                                              child: Center(
                                                child: Text(
                                                  'no_matching_data_found'.tr(),
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .bodyMedium
                                                      ?.copyWith(
                                                    color: Colors.grey,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }

                                          return VegetableCategoryListWidget(categoryResponse: vegetableCategoryList);

                                        }
                                        return const SizedBox.shrink();
                                      }
                                  )
                                ],
                              ),
                            ),
                            // _emptyState(
                            //   text: "No Vegetables Available".tr(),
                            // ),
                            _emptyState(
                              text: "No Grocery Available".tr(),
                            ),
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
