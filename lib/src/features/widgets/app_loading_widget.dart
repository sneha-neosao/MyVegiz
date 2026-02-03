import 'package:flutter/material.dart';
import 'package:myvegiz_flutter/src/core/utils/circular_indicator.dart';

import '../../core/themes/app_color.dart';

/// Displays a centered animated gradient circular loading indicator.
class AppLoadingWidget extends StatelessWidget {
  final double strokeWidth;

  const AppLoadingWidget({super.key,required this.strokeWidth});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedGradientCircularProgress(
        size: 41,
        strokeWidth: strokeWidth,
        colors: [
          AppColor.green,
          AppColor.darkGreen,
        ],
      ),
    );
  }
}
