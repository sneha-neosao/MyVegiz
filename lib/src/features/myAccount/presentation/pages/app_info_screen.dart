import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/myAccount/widgets/app_info_custom_widget.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

import '../../../../configs/injector/injector.dart';

class AppInfoScreen extends StatefulWidget {

  const AppInfoScreen({super.key,});

  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
  // late CityListBloc _cityListBloc;
  // String? selectedCityCode;
  // String? clientCode;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _cityListBloc =getIt<CityListBloc>();
  //   _cityListBloc.add(CityListGetEvent());
  // }

  void _editProfile(BuildContext context) {
    primaryFocus?.unfocus();
    final authForm = context.read<EditProfileFormBloc>().state;

    context.read<EditProfileBloc>().add(
      EditProfileGetEvent(
          authForm.clientCode.trim(),
          authForm.name.trim(),
          authForm.emailId.trim(),
          authForm.cityCode.trim()
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return
      // MultiBlocProvider(
      // providers: [
      //   // BlocProvider(create: (_) => _cityListBloc),
      //   // BlocProvider(create: (_) => getIt<EditProfileFormBloc>()),
      //   // BlocProvider(create: (_) => getIt<EditProfileBloc>())
      // ],
      // child:
      Scaffold(
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
                      'app_info'.tr(),
                      style: GoogleFonts.mavenPro(
                          color: AppColor.black,fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    SizedBox(height: 28,width: 28,)
                  ],
                ),
                16.hS,
                AppInfoCustomWidget(),
              ],
            ),
          ),
        ),
      // ),
    );
  }
}
