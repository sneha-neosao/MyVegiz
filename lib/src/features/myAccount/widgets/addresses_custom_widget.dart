import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

class AddressesCustomWidget extends StatelessWidget {
  const AddressesCustomWidget({super.key});

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
          child: InkWell(
            onTap: (){
              context.pushNamed(AppRoute.addressesScreen.name);
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset("assets/icons/location_icon.png",height:24,width: 24,),
                      8.wS,
                      Text(
                        "edit_add_addresses".tr(),
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
        )
    );
  }
}
