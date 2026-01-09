import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/widgets/vegetable_category_list_widgte.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/widgets/vegetable_slider_selection_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_snackbar_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/search_text_field_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/vegetable_category_shimmer_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../configs/injector/injector.dart';
import '../../../configs/injector/injector_conf.dart';

class GroceryTabWidget extends StatefulWidget {
  final String cityCode;

  const GroceryTabWidget({super.key, required this.cityCode});

  @override
  State<GroceryTabWidget> createState() => _GroceryTabWidgetState();
}

class _GroceryTabWidgetState extends State<GroceryTabWidget> {
  late CategoryBloc _vegetableCategoryBloc;
  late SliderBloc _vegetableSliderBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vegetableSliderBloc = getIt<SliderBloc>()..add(SliderGetEvent(widget.cityCode, "MCAT_2"));
    _vegetableCategoryBloc = getIt<CategoryBloc>()..add(CategoryGetEvent("0", "MCAT_2"));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _vegetableSliderBloc),
        BlocProvider(create: (_) => _vegetableCategoryBloc)
      ],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0,vertical: 14),
        child: Column(
          crossAxisAlignment : CrossAxisAlignment.start,
          children: [
            Text(
              'grocery'.tr(),
              style: GoogleFonts.mavenPro(
                  color: AppColor.black,fontSize: 24, fontWeight: FontWeight.bold),
            ),
            16.hS,
            SearchTextField(
                hint: "search_product_by_name".tr(),
                onChanged: (val){}
            ),
            16.hS,
            BlocConsumer<SliderBloc, SliderState>(
              listener: (context, state) {
                if (state is SliderFailureState) {
                  appSnackBar(context, AppColor.brightRed, state.message);
                }
              },
              builder: (context, state) {
                if (state is SliderLoadingState) {
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
                } else if (state is SliderSuccessState) {
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
            BlocConsumer<CategoryBloc, CategoryState>(
                listener: (context, state) {
                  if (state is CategoryFailureState) {
                    appSnackBar(context, AppColor.brightRed, state.message);
                  }
                },
                builder: (context, state) {
                  if (state is CategoryLoadingState) {
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
                  } else if (state is CategorySuccessState) {
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
    );
  }
}
