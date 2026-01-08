import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:shimmer/shimmer.dart';

class VegetableCategoryShimmerWidget extends StatefulWidget {
  const VegetableCategoryShimmerWidget({super.key});

  @override
  State<VegetableCategoryShimmerWidget> createState() => _VegetableCategoryShimmerWidgetState();
}

class _VegetableCategoryShimmerWidgetState extends State<VegetableCategoryShimmerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[400]!,
          highlightColor: Colors.grey[50]!,
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        5.hS,
        Shimmer.fromColors(
          baseColor: Colors.grey[400]!,
          highlightColor: Colors.grey[50]!,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.0),
              child: Container(
                height: 11,
                width: 45.w,
                color: Colors.white,
              )
          ),
        )
      ],
    );
  }
}
