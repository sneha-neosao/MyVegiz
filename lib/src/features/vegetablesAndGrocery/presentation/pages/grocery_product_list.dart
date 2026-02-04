import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/session/session_manager.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/widgets/product_by_category_list_widget.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

import '../../../../configs/injector/injector_conf.dart';
import '../../../../core/themes/app_color.dart';

class GroceryProductList extends StatefulWidget {
  final String cityCode;
  final String categorySName;

  const GroceryProductList({super.key, required this.cityCode, required this.categorySName,});

  @override
  State<GroceryProductList> createState() => _GroceryProductListState();
}

class _GroceryProductListState extends State<GroceryProductList> {
  late ProductByCategoryBloc _productByCategoryBloc;
  late String clienCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadClientCode();
    _productByCategoryBloc = getIt<ProductByCategoryBloc>()..add(ProductByCategoryGetEvent("0", "MCAT_2", widget.cityCode, widget.categorySName));
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
          BlocProvider(create: (_) => _productByCategoryBloc),
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
                                context.pushNamed(AppRoute.vegetablesAndGroceryScreen.name,
                                    extra: widget.cityCode
                                );
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
                      ],
                    ),
                  ),
                  16.hS,
                  Expanded(
                    child: BlocConsumer<ProductByCategoryBloc, ProductByCategoryState>(
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
                          final response = state.categoryProductMap[widget.categorySName]!;
                          final products = response.result.products;
                          return ProductByCategoryListWidget(products: products,clientCode: clienCode,);
                        } else {
                          return const Center(
                            child: Text("No products found"),
                          );
                        }
                      },
                    ),
                  ),
                  16.hS,
                ],
              ),
          ),
        )
    );
  }
}
