import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportCustomWidget extends StatefulWidget {
  const SupportCustomWidget({super.key});

  @override
  State<SupportCustomWidget> createState() => _SupportCustomWidgetState();
}

class _SupportCustomWidgetState extends State<SupportCustomWidget> {

  Future<void> _launchCall() async {
    final Uri phoneUri = Uri.parse('tel:9373747055');
    await launchUrl(
      phoneUri,
      mode: LaunchMode.externalApplication,
    );
  }

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri.parse(
      'mailto:support@neosao.com?subject=Feedback&body=Hello',
    );
    await launchUrl(
      emailUri,
      mode: LaunchMode.externalApplication,
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
                  _launchEmail();
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/icons/mail_icon.png",height:24,width: 24,),
                          8.wS,
                          Text(
                            "email".tr(),
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
                  _launchCall();
                },
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset("assets/icons/call_icon.png",height:24,width: 24,),
                          8.wS,
                          Text(
                            "call".tr(),
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

