import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/widgets/product_by_category_list_widget.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

import '../../../../configs/injector/injector_conf.dart';
import '../../../../core/themes/app_color.dart';

class VegetablesProductList extends StatefulWidget {
  final String cityCode;
  final String categorySName;

  const VegetablesProductList({super.key, required this.cityCode, required this.categorySName});

  @override
  State<VegetablesProductList> createState() => _VegetablesProductListState();
}

class _VegetablesProductListState extends State<VegetablesProductList> {
  late ProductByCategoryBloc _productByCategoryBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productByCategoryBloc = getIt<ProductByCategoryBloc>()..add(ProductByCategoryGetEvent("0", "MCAT_1", widget.cityCode, widget.categorySName));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _productByCategoryBloc),
      ],
        child: Scaffold(
          backgroundColor: AppColor.whiteShade,
          body: SafeArea(
              child: SingleChildScrollView(
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
                                'vegetables'.tr(),
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
                    BlocConsumer<ProductByCategoryBloc, ProductByCategoryState>(
                      listener: (context, state) {
                        if (state is ProductByCategoryFailureState) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is ProductByCategoryLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is ProductByCategorySuccessState) {
                          final products = state.data.result.products;
                          return ProductListWidget(products: products);
                        } else {
                          return const Center(
                            child: Text("No products found"),
                          );
                        }
                      },
                    )

                  ],
                ),
              )
          ),
        )
    );
  }
}
