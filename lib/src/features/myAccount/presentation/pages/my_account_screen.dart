import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/features/myAccount/widgets/addresses_custom_widget.dart';
import 'package:myvegiz_flutter/src/features/myAccount/widgets/my_wishlist_custom_widget.dart';
import 'package:myvegiz_flutter/src/features/myAccount/widgets/orders_tab_widget.dart';
import 'package:myvegiz_flutter/src/features/myAccount/widgets/others_custom_widget.dart';
import 'package:myvegiz_flutter/src/features/myAccount/widgets/support_custom_widget.dart';
import 'package:myvegiz_flutter/src/features/myAccount/widgets/user_info_custom_widget.dart';

class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({super.key});

  @override
  State<MyAccountScreen> createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteShade,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserInfoCustomWidget(),
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
                MyWishlistCustomWidget(),
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
                OthersCustomWidget(),
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
          ),
        ),
      )
    );
  }
}
