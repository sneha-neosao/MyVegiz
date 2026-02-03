import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector_conf.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/register/widgets/create_account_dropdown.dart';
import 'package:myvegiz_flutter/src/features/register/widgets/create_account_input_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_button_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_loading_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_snackbar_widget.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late CityListBloc _cityListBloc;
  String? selectedCityCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cityListBloc =getIt<CityListBloc>();
    _cityListBloc.add(CityListGetEvent());
  }

  void _registration(BuildContext context) {
    primaryFocus?.unfocus();
    final authForm = context.read<RegistrationFormBloc>().state;

    context.read<RegistrationBloc>().add(
      RegistrationGetEvent(
          authForm.name.trim(),
          authForm.contactNumber.trim(),
          authForm.emailId.trim(),
          authForm.cityCode.trim()
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _cityListBloc),
        BlocProvider(create: (_) => getIt<RegistrationFormBloc>()),
        BlocProvider(create: (_) => getIt<RegistrationBloc>())
      ],
      child: Scaffold(
        backgroundColor: AppColor.whiteShade,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      InkWell(
                          onTap: (){
                            context.pushNamed(AppRoute.loginScreen.name);
                          },
                          child: Image.asset("assets/icons/back_arrow.png",height: 28, width: 28,)
                      ),
                      Spacer(),
                      Text(
                        'create_account'.tr(),
                        style: GoogleFonts.mavenPro(
                            color: AppColor.black,fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      SizedBox(height: 28,width: 28,)
                    ],
                  ),
                  CreateAccountInputWidget(),
                  BlocBuilder<CityListBloc, CityListState>(
                    builder: (context, state) {
                      if(state is CityListLoadingState){
                        return Center(child: AppLoadingWidget(strokeWidth: 6,),);
                      }else if (state is CityListSuccessState) {
                        final cities = state.data.result!.cities;
              
                        return CreateAccountDropdown<String>(
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
                  BlocConsumer<RegistrationBloc,RegistrationState>(
                    listener: (context, state){
                      if(state is RegistrationFailureState){
                        appSnackBar(context, AppColor.brightRed, state.message);
                      }else if(state is RegistrationSuccessState){
                        appSnackBar(context, AppColor.green, state.data.message);
                        context.pushNamed(AppRoute.homeContentScreen.name);
                      }
                    },
                    builder: (context, state) {
                      if (state is RegistrationLoadingState) {
                        return Center(child: AppLoadingWidget(strokeWidth: 6,));
                      }

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0),
                        child: AppButtonWidget(
                            onPressed: (){
                              _registration(context);
                            },
                            label: "continue".tr()
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
