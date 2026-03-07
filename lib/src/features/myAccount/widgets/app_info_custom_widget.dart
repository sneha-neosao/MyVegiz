import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myvegiz_flutter/src/core/api/api_url.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

class AppInfoCustomWidget extends StatefulWidget {
  const AppInfoCustomWidget({super.key});

  @override
  State<AppInfoCustomWidget> createState() => _AppInfoCustomWidgetState();
}

class _AppInfoCustomWidgetState extends State<AppInfoCustomWidget> {
  Widget _itemContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColor.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        /// Application Name
        InkWell(
          onTap: () {
            context.pushNamed(
                AppRoute.webViewScreen.name,
                extra: {
                  'title': "my_vegiz".tr(),
                  'url': ApiUrl.domainUrl
                }
            );
          },
          child: _itemContainer(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/home_icon.png",
                  height: 24,
                  width: 24,
                  color: AppColor.orange,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "application_name".tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "my_vegiz".tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColor.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        14.hS,

        /// Privacy Policy
        InkWell(
          onTap: (){
            context.pushNamed(
                AppRoute.webViewScreen.name,
                extra: {
                  'title': "privacy_and_policy".tr(),
                  'url': ApiUrl.domainUrl+ApiUrl.privacyUrl
                }
            );
          },
          child: _itemContainer(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/terms_icon.png",
                  height: 24,
                  width: 24,
                  color: AppColor.orange,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "privacy_and_policy".tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "privacy_policy_disclaimer".tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColor.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        14.hS,

        /// Terms and Conditions
        InkWell(
          onTap: () {
            context.pushNamed(
                AppRoute.webViewScreen.name,
                extra: {
                  'title': "terms_and_conditions".tr(),
                  'url': ApiUrl.domainUrl+ApiUrl.termsConditionUrl
                }
            );
          },
          child: _itemContainer(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/terms_icon.png",
                  height: 24,
                  width: 24,
                  color: AppColor.orange,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "terms_and_conditions".tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "tap_for_more_details".tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColor.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        14.hS,

        /// Copyright
        InkWell(
          onTap: () {
            context.pushNamed(
                AppRoute.webViewScreen.name,
                extra: {
                  'title': "copyright".tr(),
                  'url': ApiUrl.copyRightUrl
                }
            );
          },
          child: _itemContainer(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/copyright_icon.png",
                  height: 24,
                  width: 24,
                  color: AppColor.orange,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "copyright".tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColor.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "copyright_text".tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColor.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        14.hS,

        /// Contact
        InkWell(
          onTap: () {
            context.pushNamed(
                AppRoute.webViewScreen.name,
                extra: {
                  'title': "contact_details".tr(),
                  'url': ApiUrl.domainUrl+ApiUrl.contactDetailsUrl
                }
            );
          },
          child: _itemContainer(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/call_icon.png",
                  height: 24,
                  width: 24,
                  color: AppColor.orange,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "contact_details".tr(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColor.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}