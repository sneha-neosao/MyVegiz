import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/session/session_manager.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/myAccount/widgets/addresses_custom_widget.dart';
import 'package:myvegiz_flutter/src/features/myAccount/widgets/my_wishlist_custom_widget.dart';
import 'package:myvegiz_flutter/src/features/myAccount/widgets/orders_tab_widget.dart';
import 'package:myvegiz_flutter/src/features/myAccount/widgets/others_custom_widget.dart';
import 'package:myvegiz_flutter/src/features/myAccount/widgets/support_custom_widget.dart';
import 'package:myvegiz_flutter/src/features/myAccount/widgets/user_info_custom_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_loading_widget.dart';
import 'package:myvegiz_flutter/src/features/widgets/app_snackbar_widget.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

import '../../../../configs/injector/injector_conf.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  late SignInBloc _signInBloc;
  late String clienCode;
  late String citCode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadClientCode();
    _signInBloc = getIt<SignInBloc>()..add(AuthCheckLoginStatusEvent());
  }

  void _loadClientCode() async {
    final clientCode = await SessionManager.getClientCode();
    final cityCode = await SessionManager.getCityCode();

    setState(() {
      clienCode = clientCode!;
      citCode = cityCode!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _signInBloc),
      ],
      child: Scaffold(
        backgroundColor: AppColor.whiteShade,
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocConsumer<SignInBloc,SignInState>(
              listener: (context, state) async {
                if (state is AccountDeleteLoadingState || state is AuthLogOutLoadingState) {
                  showDialog(context: context, builder: (_) => const AppLoadingWidget(strokeWidth: 6,));
                } else if (state is AccountDeleteSuccessState) {
                  if (Navigator.canPop(context)) context.pop();
                  await SessionManager.clear();
                  appSnackBar(context, Colors.green, state.data.message ?? '');
                  context.goNamed(AppRoute.loginScreen.name);
                } else if (state is AccountDeleteFailureState) {
                  if (Navigator.canPop(context)) context.pop();
                  appSnackBar(context, Colors.red, state.message);
                } else if (state is AuthLogOutSuccessState) {
                  if (Navigator.canPop(context)) context.pop();
                  appSnackBar(context, Colors.green, state.message);
                  context.goNamed(AppRoute.loginScreen.name);
                } else if (state is AuthLogOutFailureState) {
                  if (Navigator.canPop(context)) context.pop();
                  appSnackBar(context, Colors.red, state.message);
                }
              },
                builder: (context, state){
                  if(state is AuthCheckLoginStatusSuccessState){
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserInfoCustomWidget(userData: state.userData,),
                          20.hS,
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              "addresses".tr(),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColor.gray,
                                  fontWeight: FontWeight.bold,fontSize: 14
                              ),
                            ),
                          ),
                          10.hS,
                          AddressesCustomWidget(),
                          20.hS,
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              "my_wishlist".tr(),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColor.gray,
                                  fontWeight: FontWeight.bold,fontSize: 14
                              ),
                            ),
                          ),
                          10.hS,
                          MyWishlistCustomWidget(cityCode: citCode,clientCode: clienCode,),
                          20.hS,
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              "support".tr(),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColor.gray,
                                  fontWeight: FontWeight.bold,fontSize: 14
                              ),
                            ),
                          ),
                          10.hS,
                          SupportCustomWidget(),
                          20.hS,
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              "others".tr(),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColor.gray,
                                  fontWeight: FontWeight.bold,fontSize: 14
                              ),
                            ),
                          ),
                          10.hS,
                          OthersCustomWidget(userData: state.userData,),
                          40.hS,
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              "my_orders".tr(),
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: AppColor.gray,
                                  fontWeight: FontWeight.bold,fontSize: 14
                              ),
                            ),
                          ),
                          10.hS,
                          OrdersTabWidget()
                        ],
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
            )
          ),
        )
      ),
    );
  }
}
