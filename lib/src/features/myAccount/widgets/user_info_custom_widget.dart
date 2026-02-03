import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';
import 'package:myvegiz_flutter/src/remote/models/profile_details_model/profile_details_response.dart';
import 'package:myvegiz_flutter/src/remote/models/user_model/user_model.dart';
import 'package:myvegiz_flutter/src/routes/app_route_path.dart';

class UserInfoCustomWidget extends StatelessWidget {
  final UserProfile? userData;

  const UserInfoCustomWidget({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppColor.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0,horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData!.name,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColor.black,
                        fontWeight: FontWeight.bold,fontSize: 16
                    ),
                  ),
                  6.hS,
                  Text(
                    userData!.mobile,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColor.gray,
                        fontWeight: FontWeight.bold,fontSize: 14
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.0,horizontal: 24),
              child: SizedBox(
                height: 30,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.white,
                    foregroundColor: AppColor.orange,
                    elevation: 0,
                    side: BorderSide(
                      color: AppColor.orange,
                      width: 1,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  onPressed: (){
                    context.pushNamed(AppRoute.editProfileScreen.name,
                      extra: userData
                    );
                  },
                  child: Text(
                    "edit".tr(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColor.orange,
                        fontWeight: FontWeight.bold,fontSize: 12
                    ),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}
