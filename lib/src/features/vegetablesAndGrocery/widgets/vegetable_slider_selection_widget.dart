import 'package:flutter/material.dart';
import 'package:myvegiz_flutter/src/features/vegetablesAndGrocery/widgets/vegetable_slider_widget.dart';

class VegetableBannerCarouselSection extends StatelessWidget {
  final List<String> bannerUrls;

  const VegetableBannerCarouselSection({super.key, required this.bannerUrls});

  @override
  Widget build(BuildContext context) {
    return VegetableBannerCarouselWidget(banners: bannerUrls);
  }
}
