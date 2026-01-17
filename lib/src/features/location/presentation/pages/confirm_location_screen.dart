import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/session/session_manager.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/home/widgets/location_notifier.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';
import 'package:geocoding/geocoding.dart';

class ConfirmLocationScreen extends StatefulWidget {
  final LatLng? initialLatLng;

  const ConfirmLocationScreen({super.key, this.initialLatLng});

  @override
  State<ConfirmLocationScreen> createState() => _ConfirmLocationScreenState();
}

class _ConfirmLocationScreenState extends State<ConfirmLocationScreen> {
  GoogleMapController? _mapController;
  LatLng? _currentPosition;
  Set<Marker> _markers = {};
  String? _currentAddress;
  String? _currentSubLocality;
  final LatLng _initialPosition = const LatLng(16.704987, 74.243252);
  @override
  void initState() {
    super.initState();
    if (widget.initialLatLng != null)
    { // Flow from Search
      _currentPosition = widget.initialLatLng;
      _markers = { Marker(
        markerId: const MarkerId('selected_location'),
        position: widget.initialLatLng!,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ),
      };
      _updateAddressFromLatLng(widget.initialLatLng!);
    } else
    { // Flow from GPS
       _loadSavedLocation();
    }
  }

  Future<void> _loadSavedLocation() async {
    final saved = await SessionManager.getLiveLocation();
    if (saved.lat != null && saved.lng != null) {
      setState(() {
        _currentSubLocality = saved.subLocality;
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

  Future<void> _updateAddressFromLatLng(LatLng pos) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(pos.latitude, pos.longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;

        setState(() {
          // 👇 Build a detailed address string
          _currentAddress =
          "${place.street}, ${place.subLocality}, ${place.locality}, "
              "${place.administrativeArea}, ${place.postalCode}, ${place.country}";

          _currentSubLocality = place.subLocality ?? place.locality ?? "Unknown area";
        });
      }
    } catch (e) {
      debugPrint("Error in reverse geocoding: $e");
      setState(() {
        _currentAddress = "Unable to fetch address";
        _currentSubLocality = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteShade,
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _currentPosition ?? _initialPosition,
                zoom: 15,
              ),
              onMapCreated: (controller) {
                _mapController = controller;
                if (_currentPosition != null) {
                  _mapController!.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(target: _currentPosition!, zoom: 15),
                    ),
                  );
                }
              },
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              compassEnabled: true,
              zoomControlsEnabled: false,

              // 👇 Add this
              onTap: (LatLng tappedPoint) async {
                setState(() {
                  _currentPosition = tappedPoint;
                  _markers = {
                    Marker(
                      markerId: const MarkerId('selected_location'),
                      position: tappedPoint,
                      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
                    ),
                  };
                });

                // 👇 Reverse geocode to get address + subLocality
                await _updateAddressFromLatLng(tappedPoint);
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: InkWell(
                              onTap: (){
                                context.pushNamed(AppRoute.selectLocationScreen.name);
                              },
                              child: Image.asset("assets/icons/back_arrow.png",height: 28, width: 28,)
                          ),
                        ),
                        Spacer()
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SafeArea(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16)
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 34,
                                width: 34,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColor.orange.withOpacity(0.3)
                                ),
                                child: Center(
                                  child: Image.asset(
                                    "assets/icons/location_filled_icon.png",
                                    color: AppColor.orangeDark,
                                    height: 18,
                                    width: 18,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: Text(
                                  _currentSubLocality ?? "No sub locality",
                                  maxLines: 2,
                                  overflow: TextOverflow.visible,
                                  style: GoogleFonts.mavenPro(
                                    color: AppColor.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                              ),
                              Spacer(),
                              InkWell(
                                onTap: (){
                                  context.pushNamed(AppRoute.selectLocationScreen.name);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.orange.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      width: 1.2,
                                      color: AppColor.darkGreen
                                    )
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 2),
                                    child: Text(
                                      'change'.tr(),
                                      style: GoogleFonts.mavenPro(
                                          color: AppColor.darkGreen,fontSize: 14, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          12.hS,
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              _currentAddress ?? "Fetching location...",
                              maxLines: 2,
                              overflow: TextOverflow.visible,
                              style: GoogleFonts.mavenPro(
                                color: AppColor.black,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          12.hS,
                          InkWell(
                            onTap: () async {
                              if (_currentPosition != null && _currentAddress != null) {
                                // Save into SessionManager
                                await SessionManager.saveLiveLocation(
                                  latitude: _currentPosition!.latitude,
                                  longitude: _currentPosition!.longitude,
                                  address: _currentAddress!,
                                  street: _currentAddress, // or use place.street if you want exact
                                  subLocality: _currentSubLocality,
                                  locality: null, // you can extend _updateAddressFromLatLng to capture locality
                                  postalCode: null, // same for postalCode
                                );

                                LocationNotifier.notify();
                                // Navigate back or show confirmation
                                context.goNamed(AppRoute.homeContentScreen.name);

                              } else {
                                debugPrint("No location selected to save");
                              }
                            },
                            child: Container(
                              height: 51,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    AppColor.startGreenButton,
                                    AppColor.middleGreenButton,
                                    AppColor.endGreenButton,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 30),
                                  child: Text(
                                    "confirm_location".tr(),
                                    style: GoogleFonts.mavenPro(
                                      color: AppColor.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
            )
          ],
        ),
      )
    );
  }
}
