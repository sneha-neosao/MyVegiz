import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/search/widgets/search_text_field_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteShade,
      body: Column(
        children: [
          40.hS,
          SearchTextField(
              hint: "search_product_here".tr(),
              onChanged: (val){}
          )
        ],
      )
    );
  }
}
