import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector_conf.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/session/session_manager.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/search/presentation/bloc/search_product_bloc/search_product_bloc.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/widgets/product_by_category_list_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_loading_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/no_product_found_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/search_text_field_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late SearchProductBloc _searchProductBloc;
  String _cityCode = "";
  String _clientCode = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchProductBloc = getIt<SearchProductBloc>();
    _loadSessionInfo();
  }

  void _loadSessionInfo() async {
    // final cityCode = await SessionManager.getSlectedCityCode();
    final clientCode = await SessionManager.getClientCode();
    setState(() {
      _cityCode = "CTY_1";
      _clientCode = clientCode ?? "";
    });
  }

  void _onSearch(String keyword) {
    if (keyword.length >= 2) {
      _searchProductBloc.add(SearchProductByKeywordEvent(
        keyword: keyword,
        offset: "0",
        mainCategoryCode: "MCAT_1", // Defaulting to Vegetables/Grocery main category
        cityCode: _cityCode,
        clientCode: _clientCode,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _searchProductBloc,
      child: Scaffold(
        backgroundColor: AppColor.whiteShade,
        body: SafeArea(
          child: Column(
            children: [
              16.hS,
              SearchTextField(
                hint: "search_product_here".tr(),
                onChanged: _onSearch,
              ),
              16.hS,
              Expanded(
                child: BlocBuilder<SearchProductBloc, SearchProductState>(
                  builder: (context, state) {
                    if (state is SearchProductInitial) {
                    } else if (state is SearchProductLoading) {
                      return const Center(
                        child: AppLoadingWidget(strokeWidth: 4),
                      );
                    } else if (state is SearchProductSuccess) {
                      final products = state.response.result.products;
                      if (products.isEmpty) {
                        return const NoDataFoundWidget();
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ProductByCategoryListWidget(
                          products: products,
                          clientCode: _clientCode,
                        ),
                      );
                    } else if (state is SearchProductFailure) {
                      return Center(
                        child: Text(
                          state.message,
                          style: GoogleFonts.mavenPro(
                            color: AppColor.brightRed,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
