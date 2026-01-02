import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/remote/models/user_model/user_model.dart';
import 'package:share_plus/share_plus.dart';

class OthersCustomWidget extends StatefulWidget {
  final UserModel? userData;

  const OthersCustomWidget({super.key, required this.userData});

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

  /// Logout dialog
  void _logout(BuildContext context){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          final textTheme = Theme.of(dialogContext).textTheme;
          return Dialog(
            backgroundColor: Theme.of(dialogContext).cardColor,
            // Colors.black.withOpacity(0.8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Warning Icon
                  Icon(
                    Icons.error_outline_rounded,
                    color: Colors.orange,
                    size: 50,
                  ),
                  8.hS,
                  // Message
                  Text(
                      "log_out_message".tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(dialogContext).textTheme.bodyMedium
                  ),
                  8.hS,
                  Row(
                    children: [
                      /// Cancel Button
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.colorPrimary,
                          ),
                          onPressed: () {
                            dialogContext.pop(false);
                          },
                          child: Text(
                            'cancel'.tr(),
                            style: GoogleFonts.mavenPro(
                              color: AppColor.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      12.wS,
                      /// Logout Button
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.colorPrimary,
                          ),
                          onPressed: () {
                            dialogContext.pop(true);
                          },
                          child: Text(
                            'log_out_now'.tr(),
                            style: GoogleFonts.mavenPro(
                              color: AppColor.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    ).then(
          (value) => value ?? false
          ? context.read<SignInBloc>().add(AuthLogOutEvent())
          : null,
    );
  }

  /// Delete Account dialog
  void _deleteAccount(BuildContext context,String memberId){
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (dialogContext) {
          final textTheme = Theme.of(dialogContext).textTheme;
          return Dialog(
            backgroundColor: Theme.of(dialogContext).cardColor,
            // Colors.black.withOpacity(0.8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Warning Icon
                  Icon(
                    Icons.error_outline_rounded,
                    color: Colors.orange,
                    size: 50,
                  ),
                  8.hS,
                  // Message
                  Text(
                      "delete_account_message".tr(),
                      textAlign: TextAlign.center,
                      style: Theme.of(dialogContext).textTheme.bodyMedium
                  ),
                  8.hS,
                  Row(
                    children: [
                      /// Cancel Button
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.colorPrimary,
                          ),
                          onPressed: () {
                            dialogContext.pop(false);
                          },
                          child: Text(
                            'cancel'.tr(),
                            style: GoogleFonts.mavenPro(
                              color: AppColor.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      12.wS,
                      /// Logout Button
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.colorPrimary,
                          ),
                          onPressed: () {
                            dialogContext.pop(true);
                          },
                          child: Text(
                            'delete_now'.tr(),
                            style: GoogleFonts.mavenPro(
                              color: AppColor.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }
    ).then(
          (value) => value ?? false
          ? context.read<SignInBloc>().add(AccountDeleteGetEvent(memberId))
          : null,
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
              InkWell(
                onTap: (){
                  _logout(context);
                },
                child: Container(
                  child: Row(
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
                ),
              ),
              14.hS,
              Container(
                height: 1,
                color: AppColor.hintText,
              ),
              14.hS,
              InkWell(
                onTap: (){
                  _deleteAccount(context, widget.userData!.code);
                },
                child: Container(
                  child: Row(
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
                ),
              ),
            ],
          ),
        )
    );
  }
}

