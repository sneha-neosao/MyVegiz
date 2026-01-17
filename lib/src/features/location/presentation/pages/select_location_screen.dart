import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmaps;
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/widgets/search_text_field_widget.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

class SelectLocationScreen extends StatefulWidget {
  const SelectLocationScreen({super.key});

  @override
  State<SelectLocationScreen> createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  final _searchController = TextEditingController();

  final _places = FlutterGooglePlacesSdk(
    "AIzaSyCZw4DVNyJwP85ZeDG1y_x8DLQ7bF8J0EU",
  );

  List<AutocompletePrediction> _predictions = [];

  Future<void> _onSearchChanged(String value) async {
    if (value.trim().isEmpty) {
      setState(() => _predictions.clear());
      return;
    }

    final response = await _places.findAutocompletePredictions(
      value,
      countries: ['in'], // India
    );

    setState(() {
      _predictions = response.predictions;
    });
  }

  Future<void> _onPlaceSelected(AutocompletePrediction p) async {
    final details = await _places.fetchPlace(
      p.placeId!,
      fields: [PlaceField.Location],
    );

    final placeLatLng = details.place?.latLng;
    if (placeLatLng == null) return;

    // 👇 Construct the google_maps_flutter LatLng
    final selectedLatLng = gmaps.LatLng(placeLatLng.lat, placeLatLng.lng);

    context.pushNamed(
      AppRoute.confirmLocationScreen.name,
      extra: selectedLatLng,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteShade,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        context.goNamed(AppRoute.homeContentScreen.name);
                      },
                      child: Image.asset(
                        "assets/icons/back_arrow.png",
                        height: 28,
                        width: 28,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: SearchTextField(
                          controller: _searchController,
                          hint: "search_location_here".tr(),
                          onChanged: _onSearchChanged,
                        ),
                      ),
                    )
                  ],
                ),

                /// 🔥 Google places result list
                if (_predictions.isNotEmpty)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _predictions.length,
                    itemBuilder: (context, index) {
                      final p = _predictions[index];
                      return ListTile(
                        leading: Icon(Icons.location_on, color: AppColor.orange),
                        title: Text(p.primaryText ?? ""),
                        subtitle: Text(p.secondaryText ?? ""),
                        onTap: () => _onPlaceSelected(p),
                      );
                    },
                  ),

                12.hS,

                /// Current location section (unchanged)
                InkWell(
                  onTap: () {
                    context.pushNamed(AppRoute.confirmLocationScreen.name);
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6.0),
                        child: Row(
                          children: [
                            Icon(Icons.my_location_sharp,
                                size: 18, color: AppColor.orange),
                            8.wS,
                            Text(
                              'current_location'.tr(),
                              style: GoogleFonts.mavenPro(
                                color: AppColor.orange,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      1.hS,
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 34.0),
                        child: Text(
                          'using_gps'.tr(),
                          style: GoogleFonts.mavenPro(
                            color: AppColor.hintText,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      12.hS,
                      Container(
                        height: 1,
                        color: AppColor.hintText.withOpacity(0.6),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
