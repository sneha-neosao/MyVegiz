import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/myAccount/widgets/wish_list_listview.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

import '../../../../configs/injector/injector_conf.dart';

class MyWishListScreen extends StatefulWidget {
  final String clientCode;
  final String cityCode;

  const MyWishListScreen({super.key, required this.clientCode, required this.cityCode});

  @override
  State<MyWishListScreen> createState() => _MyWishListScreenState();
}

class _MyWishListScreenState extends State<MyWishListScreen> {
  late WishListBloc _wishListBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _wishListBloc = getIt<WishListBloc>()..add(WishListGetEvent(widget.clientCode, 'MCAT_1', widget.cityCode));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => _wishListBloc),
      ],
      child: Scaffold(
        backgroundColor: AppColor.whiteShade,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                            'wishlist'.tr(),
                            style: GoogleFonts.mavenPro(
                                color: AppColor.black,fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          SizedBox(height: 28,width: 28,)
                        ],
                      ),
                    ],
                  ),
                ),
                16.hS,
                BlocConsumer<WishListBloc, WishListState>(
                  listener: (context, state) {
                    if (state is WishListFailureState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is WishListLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is WishListSuccessState) {
                      final wishList = state.data.result.wishlist;
                      return WishListWidget(wishList: wishList,clientCode: widget.clientCode,);
                    } else {
                      return const Center(
                        child: Text("No products found"),
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
