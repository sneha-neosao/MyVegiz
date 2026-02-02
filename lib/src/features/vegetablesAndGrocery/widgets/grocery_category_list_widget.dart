import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/remote/models/category_model/category_response.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/themes/app_color.dart';

class GroceryCategoryListWidget extends StatefulWidget {
  final CategoryResponse categoryResponse;
  // final String cityCode;

  const GroceryCategoryListWidget({super.key, required this.categoryResponse, /*required this.cityCode*/});

  @override
  State<GroceryCategoryListWidget> createState() => _GroceryCategoryListWidgetState();
}

class _GroceryCategoryListWidgetState extends State<GroceryCategoryListWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120, // adjust height as needed
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        // padding: EdgeInsets.symmetric(horizontal: 6.w),
        itemCount: widget.categoryResponse.result.categories.length,
        itemBuilder: (context, i) {
          final category = widget.categoryResponse.result.categories[i];

          return GestureDetector(
            onTap: () {

              // context.pushNamed(
              //   AppRoute.vegetableProductListScreen.name,
              //   extra: {
              //     'cityCode': widget.cityCode
              //   },
              // );

            },
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    category.categoryImage,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[400]!,
                        highlightColor: Colors.grey[50]!,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (_, __, ___) => const Icon(Icons.sports, size: 30),
                  ),
                ),
                5.hS,
                Text(
                  category.categoryName,
                  style: GoogleFonts.mavenPro(
                      color: AppColor.black,fontSize: 10, fontWeight: FontWeight.w700),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => SizedBox(width: 12.w), // same spacing as your listview
      ),
    );
  }
}
