import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/session/session_manager.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/widgets/vegetable_slider_selection_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_snackbar_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/search_text_field_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/vegetable_category_shimmer_widget.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';
import 'package:shimmer/shimmer.dart';
import 'package:myvegiz_flutter/src/remote/models/category_model/category_response.dart'
    as cat_res;
import 'package:myvegiz_flutter/src/remote/models/category_and_product_model/category_and_product_response.dart';
import '../bloc/category_and_product_bloc/category_and_product_bloc.dart';
import '../bloc/product_by_category_bloc/product_by_category_bloc.dart';
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
  late CategoryAndProductBloc _categoryAndProductBloc;
  late ProductByCategoryBloc _productByCategoryBloc;
  late String clienCode;
  List<cat_res.Category> _categories = [];
  bool _productsLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadClientCode();
    _vegetableSliderBloc = getIt<SliderBloc>()
      ..add(SliderGetEvent(widget.cityCode, "MCAT_2"));
    _categoryAndProductBloc = getIt<CategoryAndProductBloc>()
      ..add(CategoryAndProductGetEvent("0", "MCAT_2", widget.cityCode));
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
        BlocProvider(create: (_) => _categoryAndProductBloc),
      ],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'grocery'.tr(),
              style: GoogleFonts.mavenPro(
                color: AppColor.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            16.hS,
            SearchTextField(
              hint: "search_product_by_name".tr(),
              onChanged: (val) {},
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
                  final bannerUrls = result.sliderImages
                      .map((e) => e.imagePath)
                      .toList();
                  return VegetableBannerCarouselSection(bannerUrls: bannerUrls);
                }
                return const SizedBox.shrink();
              },
            ),
            22.hS,
            BlocConsumer<CategoryAndProductBloc, CategoryAndProductState>(
              listener: (context, state) {
                if (state is CategoryAndProductFailureState) {
                  appSnackBar(context, AppColor.brightRed, state.message);
                }
              },
              builder: (context, state) {
                if (state is CategoryAndProductLoadingState) {
                  return SizedBox(
                    height: 200.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (_, __) =>
                          const VegetableCategoryShimmerWidget(),
                      separatorBuilder: (_, __) => SizedBox(width: 8.w),
                    ),
                  );
                } else if (state is CategoryAndProductSuccessState) {
                  final categories = state.data.result.categories;

                  if (categories.isEmpty) {
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

                  return Column(
                    children: [
                      // Horizontal Category List (Icons)
                      _buildHorizontalCategoryList(categories),
                      16.hS,
                      // Vertical Category List with View All
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categories.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 20),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    category.categoryName,
                                    style: GoogleFonts.mavenPro(
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.black,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      context.pushNamed(
                                        AppRoute.groceryProductListScreen.name,
                                        extra: {
                                          'cityCode': widget.cityCode,
                                          'categorySName':
                                              category.categorySName,
                                        },
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'view_all'.tr(),
                                          style: GoogleFonts.mavenPro(
                                            color: AppColor.orange,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        4.wS,
                                        Image.asset(
                                          "assets/icons/view_arrow.png",
                                          height: 12,
                                          color: AppColor.orange,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              // If you want to show horizontal products below each category:
                              if (category.productList != null &&
                                  category
                                      .productList!
                                      .products
                                      .isNotEmpty) ...[
                                12.hS,
                                SizedBox(
                                  height:
                                      140, // Height for horizontal product cards
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        category.productList!.products.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(width: 12),
                                    itemBuilder: (context, pIndex) {
                                      final product = category
                                          .productList!
                                          .products[pIndex];
                                      return _buildSmallProductCard(product);
                                    },
                                  ),
                                ),
                              ],
                            ],
                          );
                        },
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHorizontalCategoryList(List<Category> categories) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: 16.w),
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              context.pushNamed(
                AppRoute.groceryProductListScreen.name,
                extra: {
                  'cityCode': widget.cityCode,
                  'categorySName': category.categorySName,
                },
              );
            },
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    category.categoryImage,
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        width: 75,
                        height: 75,
                        color: Colors.grey[200],
                      );
                    },
                    errorBuilder: (_, __, ___) => Container(
                      width: 75,
                      height: 75,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                8.hS,
                Text(
                  category.categoryName,
                  style: GoogleFonts.mavenPro(
                    color: AppColor.black,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSmallProductCard(Product product) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          AppRoute.productDetailsScreen.name,
          extra: {
            'productCode': product.code,
            'mainCategoryCode': "",
            'cityCode': widget.cityCode,
            'clientCode': clienCode,
          },
        );
      },
      child: Container(
        width: 140,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10),
                ),
                child: Image.network(
                  product.images.isNotEmpty ? product.images.first : '',
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.image),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.mavenPro(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    "₹${product.sellingPrice}",
                    style: GoogleFonts.mavenPro(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
