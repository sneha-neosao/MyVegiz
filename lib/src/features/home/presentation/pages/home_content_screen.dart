import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/home/widgets/home_slider_selection_widget.dart';
import 'package:myvegiz_flutter/src/features/home/widgets/restaurant_vegetable_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_snackbar_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../configs/injector/injector_conf.dart';

class HomeContentScreen extends StatefulWidget {
  const HomeContentScreen({super.key});

  @override
  State<HomeContentScreen> createState() => _HomeContentScreenState();
}

class _HomeContentScreenState extends State<HomeContentScreen> {
  late HomeSliderBloc _homeSliderBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeSliderBloc = getIt<HomeSliderBloc>()..add(HomeSliderGetEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _homeSliderBloc),
      ],
      child: Scaffold(
        backgroundColor: AppColor.whiteShade,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            40.hS,
            RestaurantVegetableWidget(),
            30.hS,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              child: Text(
                'todays_offers'.tr(),
                style: GoogleFonts.mavenPro(
                    color: AppColor.black,fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
            16.hS,
            BlocConsumer<HomeSliderBloc, HomeSliderState>(
              listener: (context, state) {
                if (state is HomeSliderFailureState) {
                  appSnackBar(context, AppColor.brightRed, state.message);
                }
              },
              builder: (context, state) {
                if (state is HomeSliderLoadingState) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: Colors.grey[50]!,
                      child: Container(
                        height: 186,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                } else if (state is HomeSliderSuccessState) {
                  final result = state.data.result;

                  if (result == null || result.homesliderImages.isEmpty) {
                    return Center(
                      child: Text(
                        'no_matching_data_found'.tr(),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    );
                  }

                  // Convert List<HomeSliderImage> → List<String>
                  final bannerUrls = result.homesliderImages.map((e) => e.imagePath).toList();
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                    child: BannerCarouselSection(bannerUrls: bannerUrls)
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        )
      ),
    );
  }
}
