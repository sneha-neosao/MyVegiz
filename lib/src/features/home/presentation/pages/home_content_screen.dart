import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/session/session_manager.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/home/widgets/home_slider_selection_widget.dart';
import 'package:myvegiz_flutter/src/features/home/widgets/location_notifier.dart';
import 'package:myvegiz_flutter/src/features/home/widgets/restaurant_vegetable_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_snackbar_widget.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../configs/injector/injector_conf.dart';
import '../../../../remote/models/user_model/user_model.dart';

class HomeContentScreen extends StatefulWidget {
  const HomeContentScreen({super.key});

  @override
  State<HomeContentScreen> createState() => _HomeContentScreenState();
}

class _HomeContentScreenState extends State<HomeContentScreen> {
  late HomeSliderBloc _homeSliderBloc;
  String? _currentAddress;
  String? _cityCode;

  @override
  void initState() {
    super.initState();
    _loadSavedLocation();
    LocationNotifier.refresh.addListener(_onLocationChanged);
    // _getLocation(); // existing logic preserved
    _getCityCode();
    _homeSliderBloc = getIt<HomeSliderBloc>()..add(HomeSliderGetEvent());
  }

  void _onLocationChanged() {
    _loadSavedLocation();
  }

  @override
  void dispose() {
    LocationNotifier.refresh.removeListener(_onLocationChanged);
    super.dispose();
  }

  void _getCityCode() async {
    final user = await SessionManager.getUserSessionInfo() as UserModel;
    setState(() {
      _cityCode = user.cityCode;
    });
  }

  Future<void> _loadSavedLocation() async {
    final saved = await SessionManager.getLiveLocation();
    if (saved.lat != null && saved.lng != null) {
      setState(() {
        // 👇 Construct detailed address from saved fields
        _currentAddress = [
          saved.street,
          saved.subLocality,
          saved.locality,
          saved.postalCode,
          saved.address, // fallback or extra line
        ]
            .where((e) => e != null && e.isNotEmpty)
            .join(", ");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _homeSliderBloc),
      ],
      child: Scaffold(
        backgroundColor: AppColor.whiteShade,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: InkWell(
                    onTap: () {
                      context.pushNamed(AppRoute.selectLocationScreen.name);
                    },
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: AppColor.white,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.asset(
                              "assets/icons/location_filled_icon.png",
                              height: 25,
                              width: 25,
                              color: AppColor.orangeDark,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              _currentAddress ?? "Fetching location...",
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                              style: GoogleFonts.mavenPro(
                                color: AppColor.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                20.hS,
                RestaurantVegetableWidget(cityCode: _cityCode ?? ""),
                30.hS,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14.0),
                  child: Text(
                    'todays_offers'.tr(),
                    style: GoogleFonts.mavenPro(
                      color: AppColor.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
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
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
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

                      if (result == null ||
                          result.homesliderImages.isEmpty) {
                        return Center(
                          child: Text(
                            'no_matching_data_found'.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        );
                      }

                      final bannerUrls = result.homesliderImages
                          .map((e) => e.imagePath)
                          .toList();

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        child: BannerCarouselSection(
                          bannerUrls: bannerUrls,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
