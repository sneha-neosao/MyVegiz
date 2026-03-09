import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector_conf.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/session/session_manager.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/address/bloc/addresses_bloc/addresses_bloc.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_loading_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_snackbar_widget.dart';
import 'package:myvegiz_flutter/src/remote/models/address_model/address_response.dart';

/// Screen for adding a new address or editing an existing one.
/// Pass [addressToEdit] to pre-fill fields for editing.
class AddEditAddressScreen extends StatefulWidget {
  final AddressResult? addressToEdit;

  const AddEditAddressScreen({super.key, this.addressToEdit});

  @override
  State<AddEditAddressScreen> createState() => _AddEditAddressScreenState();
}

class _AddEditAddressScreenState extends State<AddEditAddressScreen> {
  late AddressBloc _addressBloc;

  // Form controllers
  final TextEditingController _flatController = TextEditingController();
  final TextEditingController _landMarkController = TextEditingController();
  final TextEditingController _directionController = TextEditingController();

  // Map state
  GoogleMapController? _mapController;
  LatLng _selectedPosition = const LatLng(16.704987, 74.243252); // default
  Set<Marker> _markers = {};
  String _currentAddress = '';
  String _currentSubLocality = '';
  String _areaCode = '';
  String _cityCode = '';

  // Address type
  String _addressType = ''; // 'home' or 'office'

  bool get _isEditMode => widget.addressToEdit != null;

  @override
  void initState() {
    super.initState();
    _addressBloc = getIt<AddressBloc>();
    _initFields();
  }

  void _initFields() {
    final addr = widget.addressToEdit;
    if (addr != null) {
      // Edit mode: prefill
      _flatController.text = addr.flat;
      _landMarkController.text = addr.landMark;
      _directionController.text = addr.directionToReach;
      _addressType = addr.addressType;
      _areaCode = addr.areaCode;
      _cityCode = addr.cityCode;

      if (addr.latitude.isNotEmpty && addr.longitude.isNotEmpty) {
        final lat = double.tryParse(addr.latitude);
        final lng = double.tryParse(addr.longitude);
        if (lat != null && lng != null) {
          _selectedPosition = LatLng(lat, lng);
        }
      }
      _currentAddress = addr.address;
      _markers = {
        Marker(
          markerId: const MarkerId('selected'),
          position: _selectedPosition,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange,
          ),
        ),
      };
    } else {
      _loadSavedLocation();
    }
  }

  Future<void> _loadSavedLocation() async {
    final saved = await SessionManager.getLiveLocation();
    if (saved.lat != null && saved.lng != null) {
      final pos = LatLng(saved.lat!, saved.lng!);
      setState(() {
        _selectedPosition = pos;
        _markers = {
          Marker(
            markerId: const MarkerId('selected'),
            position: pos,
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueOrange,
            ),
          ),
        };
        _currentAddress = saved.address ?? '';
        _currentSubLocality = saved.subLocality ?? '';
      });
      _mapController?.animateCamera(CameraUpdate.newLatLngZoom(pos, 15));
    }
  }

  Future<void> _updateAddressFromLatLng(LatLng pos) async {
    try {
      final placemarks = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        setState(() {
          _currentAddress =
              '${place.street ?? ''}, ${place.subLocality ?? ''}, ${place.locality ?? ''}, '
              '${place.administrativeArea ?? ''}, ${place.postalCode ?? ''}, ${place.country ?? ''}';
          _currentSubLocality = place.subLocality ?? place.locality ?? '';

          // Populate text fields
          _flatController.text = place.name ?? '';
          _landMarkController.text = place.subLocality ?? '';
          _areaCode = place.postalCode ?? '';
          _cityCode = place.locality ?? '';
        });
      }
    } catch (e) {
      setState(() {
        _currentAddress = 'Unable to fetch address';
        _currentSubLocality = '';
      });
    }
  }

  void _onMapTap(LatLng pos) async {
    setState(() {
      _selectedPosition = pos;
      _markers = {
        Marker(
          markerId: const MarkerId('selected'),
          position: pos,
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueOrange,
          ),
        ),
      };
      _areaCode = ''; // reset until geocoded
      _cityCode = '';
    });
    await _updateAddressFromLatLng(pos);
  }

  void _submit() async {
    if (_currentAddress.isEmpty) {
      appSnackBar(context, Colors.red, 'Please pick a location on the map');
      return;
    }
    if (_addressType.isEmpty) {
      appSnackBar(
        context,
        Colors.red,
        'Please select address type (Home / Office)',
      );
      return;
    }
    if (_flatController.text.trim().isEmpty) {
      appSnackBar(context, Colors.red, 'Please enter flat / house name');
      return;
    }
    if (_landMarkController.text.trim().isEmpty) {
      appSnackBar(context, Colors.red, 'Please enter landmark');
      return;
    }
    if (_directionController.text.trim().isEmpty) {
      appSnackBar(context, Colors.red, 'Please enter direction to reach');
      return;
    }

    final clientCode = await SessionManager.getClientCode();
    if (!mounted) return;
    if (clientCode == null) return;

    if (_isEditMode) {
      _addressBloc.add(
        UpdateAddressEvent(
          id: widget.addressToEdit!.id,
          clientCode: clientCode,
          address: _currentAddress,
          latitude: _selectedPosition.latitude.toString(),
          longitude: _selectedPosition.longitude.toString(),
          addressType: _addressType,
          flat: _flatController.text.trim(),
          landMark: _landMarkController.text.trim(),
          directionToReach: _directionController.text.trim(),
          areaCode: _areaCode.isNotEmpty
              ? _areaCode
              : widget.addressToEdit!.areaCode,
          cityCode: _cityCode.isNotEmpty
              ? _cityCode
              : widget.addressToEdit!.cityCode,
        ),
      );
    } else {
      _addressBloc.add(
        AddAddressEvent(
          clientCode: clientCode,
          address: _currentAddress,
          latitude: _selectedPosition.latitude.toString(),
          longitude: _selectedPosition.longitude.toString(),
          addressType: _addressType,
          flat: _flatController.text.trim(),
          landMark: _landMarkController.text.trim(),
          directionToReach: _directionController.text.trim(),
          areaCode: _areaCode,
          cityCode: _cityCode,
        ),
      );
    }
  }

  @override
  void dispose() {
    _flatController.dispose();
    _landMarkController.dispose();
    _directionController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _addressBloc,
      child: BlocListener<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state is AddAddressLoading || state is UpdateAddressLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const AppLoadingWidget(strokeWidth: 6),
            );
          } else if (state is AddAddressSuccess) {
            if (Navigator.canPop(context)) context.pop(); // close loader
            appSnackBar(context, Colors.green, state.message);
            context.pop(true); // pop screen with result=true to trigger refresh
          } else if (state is AddAddressError) {
            if (Navigator.canPop(context)) context.pop();
            appSnackBar(context, Colors.red, state.message);
          } else if (state is UpdateAddressSuccess) {
            if (Navigator.canPop(context)) context.pop();
            appSnackBar(context, Colors.green, state.message);
            context.pop(true);
          } else if (state is UpdateAddressError) {
            if (Navigator.canPop(context)) context.pop();
            appSnackBar(context, Colors.red, state.message);
          }
        },
        child: Scaffold(
          backgroundColor: AppColor.whiteShade,
          body: SafeArea(
            child: Column(
              children: [
                // ── Map Section ──────────────────────────────────────────
                SizedBox(
                  height: 260,
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: _selectedPosition,
                          zoom: 15,
                        ),
                        onMapCreated: (controller) {
                          _mapController = controller;
                          _mapController!.animateCamera(
                            CameraUpdate.newLatLngZoom(_selectedPosition, 15),
                          );
                        },
                        markers: _markers,
                        myLocationEnabled: true,
                        myLocationButtonEnabled: true,
                        zoomControlsEnabled: false,
                        compassEnabled: true,
                        onTap: _onMapTap,
                      ),
                      // Back button
                      Positioned(
                        top: 12,
                        left: 12,
                        child: InkWell(
                          onTap: () => context.pop(),
                          child: Container(
                            height: 36,
                            width: 36,
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 4),
                              ],
                            ),
                            child: const Icon(Icons.arrow_back, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Form Section ─────────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Selected address preview
                        if (_currentAddress.isNotEmpty) ...[
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: AppColor.orange,
                                size: 18,
                              ),
                              8.wS,
                              Expanded(
                                child: Text(
                                  _currentSubLocality.isNotEmpty
                                      ? _currentSubLocality
                                      : _currentAddress,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.mavenPro(
                                    color: AppColor.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          4.hS,
                          Padding(
                            padding: const EdgeInsets.only(left: 26),
                            child: Text(
                              _currentAddress,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.mavenPro(
                                color: AppColor.hintText,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          12.hS,
                          Divider(color: AppColor.hintText.withOpacity(0.3)),
                          12.hS,
                        ],

                        // Address type selector
                        Text(
                          'Save as',
                          style: GoogleFonts.mavenPro(
                            fontSize: 13,
                            color: AppColor.gray,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        8.hS,
                        Row(
                          children: [
                            _buildTypeChip('home', Icons.home_outlined, 'Home'),
                            12.wS,
                            _buildTypeChip(
                              'office',
                              Icons.business_outlined,
                              'Office',
                            ),
                          ],
                        ),
                        16.hS,

                        // Flat / House name
                        _buildTextField(
                          controller: _flatController,
                          label: 'Flat / House No / Block No *',
                          hint: 'e.g. A-203, Neosao Tower',
                          icon: Icons.home_work_outlined,
                        ),
                        12.hS,

                        // Landmark
                        _buildTextField(
                          controller: _landMarkController,
                          label: 'Landmark *',
                          hint: 'e.g. Near Railway Station',
                          icon: Icons.place_outlined,
                        ),
                        12.hS,

                        // Direction to reach
                        _buildTextField(
                          controller: _directionController,
                          label: 'Direction to Reach *',
                          hint: 'e.g. Take left from main gate',
                          icon: Icons.directions_outlined,
                          maxLines: 2,
                        ),
                        24.hS,

                        // Save button
                        InkWell(
                          onTap: _submit,
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
                              child: Text(
                                _isEditMode ? 'Update Address' : 'Save Address',
                                style: GoogleFonts.mavenPro(
                                  color: AppColor.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                        16.hS,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeChip(String type, IconData icon, String label) {
    final bool isSelected = _addressType == type;
    return InkWell(
      onTap: () => setState(() => _addressType = type),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.darkGreen.withOpacity(0.1)
              : AppColor.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? AppColor.darkGreen
                : AppColor.hintText.withOpacity(0.4),
            width: 1.4,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? AppColor.darkGreen : AppColor.gray,
            ),
            6.wS,
            Text(
              label,
              style: GoogleFonts.mavenPro(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? AppColor.darkGreen : AppColor.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.mavenPro(
            fontSize: 12,
            color: AppColor.gray,
            fontWeight: FontWeight.w500,
          ),
        ),
        6.hS,
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          style: GoogleFonts.mavenPro(fontSize: 13, color: AppColor.black),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.mavenPro(
              fontSize: 12,
              color: AppColor.hintText,
            ),
            prefixIcon: Icon(icon, size: 18, color: AppColor.gray),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            filled: true,
            fillColor: AppColor.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColor.hintText.withOpacity(0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColor.hintText.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColor.darkGreen,
                width: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
