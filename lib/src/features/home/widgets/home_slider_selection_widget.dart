import 'package:flutter/material.dart';
import 'package:myvegiz_flutter/src/features/home/widgets/home_slider_widget.dart';

class BannerCarouselSection extends StatelessWidget {
  final List<String> bannerUrls;

  const BannerCarouselSection({super.key, required this.bannerUrls});

  @override
  Widget build(BuildContext context) {
    return BannerCarouselWidget(banners: bannerUrls);
  }
}
