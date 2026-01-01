import 'package:flutter/material.dart';
import 'package:myvegiz_flutter/src/core/utils/circular_indicator.dart';

import '../../core/themes/app_color.dart';

/// Displays a centered animated gradient circular loading indicator.
class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: AnimatedGradientCircularProgress(
        size: 41,
        strokeWidth: 6,
        colors: [
          AppColor.green,
          AppColor.darkGreen,
        ],
      ),
    );
  }
}
