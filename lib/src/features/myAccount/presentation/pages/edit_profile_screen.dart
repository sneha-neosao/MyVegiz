import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/session/session_manager.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/myAccount/widgets/edit_profile_dropdown.dart';
import 'package:myvegiz_flutter/src/features/myAccount/widgets/edit_profile_input_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_button_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_loading_widget.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

import '../../../../configs/injector/injector.dart';
import '../../../../configs/injector/injector_conf.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late CityListBloc _cityListBloc;
  String? selectedCityCode;
  String? clientCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cityListBloc =getIt<CityListBloc>();
    _cityListBloc.add(CityListGetEvent());
    _loadUserInfo();
  }

  void _editProfile(BuildContext context) {
    primaryFocus?.unfocus();
    final authForm = context.read<EditProfileFormBloc>().state;

    context.read<EditProfileBloc>().add(
      EditProfileGetEvent(
          authForm.name.trim(),
          authForm.clientCode.trim(),
          authForm.emailId.trim(),
          authForm.cityCode.trim()
      ),
    );
  }

  Future<void> _loadUserInfo() async {
    final user = await SessionManager.getUserSessionInfo(); // returns UserModel
    if (user != null) {
      // Prefill form bloc with saved values
      setState(() {
        clientCode = user.clientCode;
        selectedCityCode = user.cityCode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _cityListBloc),
        BlocProvider(create: (_) => getIt<EditProfileFormBloc>()),
        BlocProvider(create: (_) => getIt<EditProfileBloc>())
      ],
      child: Scaffold(
        backgroundColor: AppColor.whiteShade,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: (){
                        context.goNamed(AppRoute.myAccountScreen.name);
                      },
                        child: Image.asset("assets/icons/back_arrow.png",height: 28, width: 28,)
                    ),
                    Spacer(),
                    Text(
                      'edit_profile'.tr(),
                      style: GoogleFonts.mavenPro(
                          color: AppColor.black,fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    SizedBox(height: 28,width: 28,)
                  ],
                ),
                EditProfileInputWidget(),
                BlocBuilder<CityListBloc, CityListState>(
                  builder: (context, state) {
                    if(state is CityListLoadingState){
                      return Center(child: AppLoadingWidget(),);
                    }else if (state is CityListSuccessState) {
                      final cities = state.data.result!.cities;

                      return EditProfileDropdown<String>(
                        label: "city".tr(),
                        hint: "select_city".tr(),

                        // ✅ Convert CityModel → String
                        items: cities.map((e) => e.code ?? "").toList(),

                        value: selectedCityCode,

                        // ✅ Convert code → city name
                        itemLabel: (code) {
                          final city = cities.firstWhere(
                                (c) => c.code == code,
                          );
                          return city.cityName ?? "";
                        },

                        onChanged: (code) {
                          setState(() {
                            selectedCityCode = code;
                          });

                          // ✅ send to form bloc
                          context.read<RegistrationFormBloc>().add(
                            RegistrationFormCityCodeChangedEvent(code ?? ''),
                          );

                          final selectedCity = cities.firstWhere(
                                (c) => c.code == code,
                          );

                          print("City Name: ${selectedCity.cityName}");
                          print("City Code: ${selectedCity.code}");
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
                24.hS,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: AppButtonWidget(
                      onPressed: (){},
                      label: "update_profile".tr()
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
