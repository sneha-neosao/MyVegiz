import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector_conf.dart';
import 'package:myvegiz_flutter/src/core/session/session_manager.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/address/bloc/addresses_bloc/addresses_bloc.dart';
import 'package:myvegiz_flutter/src/remote/models/address_model/address_response.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  late AddressBloc _addressBloc;

  @override
  void initState() {
    super.initState();
    _addressBloc = getIt<AddressBloc>();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    final clientCode = await SessionManager.getClientCode();
    if (clientCode != null) {
      _addressBloc.add(FetchAddressesEvent("CLNT23_2010"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _addressBloc,
      child: Scaffold(
        backgroundColor: AppColor.whiteShade,
        body: SafeArea(
          child: Column(
            children: [
              _buildAppBar(context),
              Expanded(
                child: MultiBlocListener(
                  listeners: [
                    BlocListener<AddressBloc, AddressState>(
                      listener: (context, state) {
                        if (state is AddressError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        }
                      },
                    ),
                  ],
                  child: BlocBuilder<AddressBloc, AddressState>(
                    builder: (context, state) {
                      if (state is AddressLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColor.colorPrimary,
                          ),
                        );
                      } else if (state is AddressLoaded) {
                        final addresses =
                            state.response.result?.addresses ?? [];
                        if (addresses.isEmpty) {
                          return _buildEmptyState();
                        }
                        return _buildAddressList(addresses);
                      } else if (state is AddressError) {
                        return _buildEmptyState(); // Optionally show empty state on error
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              context.goNamed(AppRoute.myAccountScreen.name);
            },
            child: Image.asset(
              "assets/icons/back_arrow.png",
              height: 28,
              width: 28,
            ),
          ),
          const Spacer(),
          Text(
            'address'.tr(),
            style: GoogleFonts.mavenPro(
              color: AppColor.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          OutlinedButton(
            onPressed: () {
              // context.pushNamed(AppRoute.addAddressScreen.name);
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColor.startOrangeButton),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              minimumSize: const Size(0, 32),
            ),
            child: Text(
              "Add Address",
              style: GoogleFonts.mavenPro(
                color: AppColor.startOrangeButton,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressList(List<AddressResult> addresses) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        final address = addresses[index];
        return Card(
          elevation: 0,
          margin: const EdgeInsets.only(bottom: 12.0),
          color: AppColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: AppColor.grayShade.withOpacity(0.1)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  address.addressType.toUpperCase(),
                  style: GoogleFonts.mavenPro(
                    color: AppColor.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  address.address,
                  style: GoogleFonts.mavenPro(
                    color: AppColor.black,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (address.flat.isNotEmpty || address.landMark.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    "${address.flat}${address.flat.isNotEmpty && address.landMark.isNotEmpty ? ", " : ""}${address.landMark}",
                    style: GoogleFonts.mavenPro(
                      color: AppColor.grayShade,
                      fontSize: 12,
                    ),
                  ),
                ],
                const SizedBox(height: 2),
                Text(
                  "${address.city}, ${address.area}",
                  style: GoogleFonts.mavenPro(
                    color: AppColor.grayShade,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // Edit logic
                      },
                      child: Text(
                        'EDIT',
                        style: GoogleFonts.mavenPro(
                          color: AppColor.darkGreen,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 32),
                    InkWell(
                      onTap: () {
                        // Delete logic
                      },
                      child: Text(
                        'DELETE',
                        style: GoogleFonts.mavenPro(
                          color: AppColor.orange,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_off_outlined,
            size: 80,
            color: AppColor.gray,
          ),
          const SizedBox(height: 16),
          Text(
            'no_address_found'.tr(),
            style: GoogleFonts.mavenPro(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColor.gray,
            ),
          ),
        ],
      ),
    );
  }
}
