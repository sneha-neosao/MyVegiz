import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/widgets/product_by_card_widget.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/widgets/vegetable_category_list_widgte.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/widgets/vegetable_slider_selection_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_snackbar_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/search_text_field_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/vegetable_category_shimmer_widget.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';
import 'package:shimmer/shimmer.dart';
import 'package:myvegiz_flutter/src/remote/models/category_model/category_response.dart';
import '../../../configs/injector/injector.dart';
import '../../../configs/injector/injector_conf.dart';
import '../../../core/session/session_manager.dart';

class VegetableTabWidget extends StatefulWidget {
  final String cityCode;

  const VegetableTabWidget({super.key, required this.cityCode});

  @override
  State<VegetableTabWidget> createState() => _VegetableTabWidgetState();
}

class _VegetableTabWidgetState extends State<VegetableTabWidget> {
  late CategoryBloc _vegetableCategoryBloc;
  late SliderBloc _vegetableSliderBloc;
  late ProductByCategoryBloc _productByCategoryBloc;
  late String clienCode;
  List<Category> _categories = [];
  bool _productsLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadClientCode();
    _vegetableSliderBloc = getIt<SliderBloc>()..add(SliderGetEvent(widget.cityCode, "MCAT_1"));
    _vegetableCategoryBloc = getIt<CategoryBloc>()..add(CategoryGetEvent("0", "MCAT_1"));
    _productByCategoryBloc = getIt<ProductByCategoryBloc>();
  }

  void _loadClientCode() async {
    final clientCode = await SessionManager.getClientCode();
    setState(() {
      clienCode = clientCode!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _vegetableSliderBloc),
        BlocProvider(create: (_) => _vegetableCategoryBloc),
        BlocProvider(create: (_) => _productByCategoryBloc)
      ],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0,vertical: 14),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment : CrossAxisAlignment.start,
            children: [
              Text(
                'vegetables_fruits'.tr(),
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
                        height: 120.h,
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

                      _categories = vegetableCategoryList.result.categories; // ✅ SAVE ORDER


                      if (!_productsLoaded) {
                        for (final cat in vegetableCategoryList.result.categories) {
                          context.read<ProductByCategoryBloc>().add( ProductByCategoryGetEvent("0", cat.mainCategoryCode, widget.cityCode,cat.categorySName), );
                        }
                        _productsLoaded = true;
                      }

                      return VegetableCategoryListWidget(categoryResponse: vegetableCategoryList, cityCode: widget.cityCode,);
          
                    }
                    return const SizedBox.shrink();
                  }
              ),
              16.hS,
              BlocBuilder<ProductByCategoryBloc, ProductByCategoryState>(
                builder: (context, state) {
                  if (state is ProductByCategorySuccessState) {
                    return Column(
                      children: _categories.map((cat) {
                        final response =
                        state.categoryProductMap[cat.categorySName];

                        if (response == null ||
                            response.result.products.isEmpty) {
                          return const SizedBox.shrink();
                        }

                        final products = response.result.products;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  cat.categoryName, // ✅ correct order
                                  style: GoogleFonts.mavenPro(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    context.pushNamed(
                                      AppRoute.vegetableProductListScreen.name,
                                      extra: {
                                        'cityCode': widget.cityCode,
                                        'categorySName': cat.categorySName
                                      },
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'view_all'.tr(),
                                        style: GoogleFonts.mavenPro(
                                            color: AppColor.orange,fontSize: 12, fontWeight: FontWeight.bold),
                                      ),
                                      4.wS,
                                      Image.asset("assets/icons/view_arrow.png"),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            8.hS,
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: products.length,
                              separatorBuilder: (_, __) => const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                return CategoryByProductCardWidget(
                                  product: products[index],
                                  clientCode: clienCode,
                                );
                              },
                            ),
                            16.hS,
                          ],
                        );
                      }).toList(),
                    );
                  }
                  return const SizedBox.shrink();
                },
              )

        // CategoryProductCardWidget(product: null,)
            ],
          ),
        ),
      ),
    );
  }
}
