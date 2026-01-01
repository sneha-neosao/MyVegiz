import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:share_plus/share_plus.dart';

class OthersCustomWidget extends StatefulWidget {
  const OthersCustomWidget({super.key});

  @override
  State<OthersCustomWidget> createState() => _OthersCustomWidgetState();
}

class _OthersCustomWidgetState extends State<OthersCustomWidget> {

  void shareApp(BuildContext context) {
    final String appName = "MyVegiz";
    final String packageName = "com.myvegiz.app"; // your actual package name

    Share.share(
      "Try this $appName App:\nhttps://play.google.com/store/apps/details?id=$packageName",
      subject: appName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 14.0,horizontal: 12),
          child: Column(
            children: [
              InkWell(
                onTap: (){
                  shareApp(context);
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/icons/share_icon.png",height:24,width: 24,),
                          8.wS,
                          Text(
                            "share".tr(),
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColor.black,
                                fontWeight: FontWeight.normal,fontSize: 14
                            ),
                          ),
                        ],
                      ),
                      Image.asset("assets/icons/right_arrow_icon.png",height:16,width: 16,)
                    ],
                  ),
                ),
              ),
              14.hS,
              Container(
                height: 1,
                color: AppColor.hintText,
              ),
              14.hS,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/icons/rate_icon.png",height:24,width: 24,),
                      8.wS,
                      Text(
                        "rate_app".tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.normal,fontSize: 14
                        ),
                      ),
                    ],
                  ),
                  Image.asset("assets/icons/right_arrow_icon.png",height:16,width: 16,)
                ],
              ),
              14.hS,
              Container(
                height: 1,
                color: AppColor.hintText,
              ),
              14.hS,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/icons/help_icon.png",height:24,width: 24,),
                      8.wS,
                      Text(
                        "app_info".tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.normal,fontSize: 14
                        ),
                      ),
                    ],
                  ),
                  Image.asset("assets/icons/right_arrow_icon.png",height:16,width: 16,)
                ],
              ),
              14.hS,
              Container(
                height: 1,
                color: AppColor.hintText,
              ),
              14.hS,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/icons/logout_icon.png",height:24,width: 24,),
                      8.wS,
                      Text(
                        "logout".tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.normal,fontSize: 14
                        ),
                      ),
                    ],
                  ),
                  Image.asset("assets/icons/right_arrow_icon.png",height:16,width: 16,)
                ],
              ),
              14.hS,
              Container(
                height: 1,
                color: AppColor.hintText,
              ),
              14.hS,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/icons/delete_icon.png",height:24,width: 24,),
                      8.wS,
                      Text(
                        "delete".tr(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColor.black,
                            fontWeight: FontWeight.normal,fontSize: 14
                        ),
                      ),
                    ],
                  ),
                  Image.asset("assets/icons/right_arrow_icon.png",height:16,width: 16,)
                ],
              ),
            ],
          ),
        )
    );
  }
}

