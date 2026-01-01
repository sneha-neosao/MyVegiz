import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/features/myAccount/widgets/edit_profile_text_field_widget.dart';

class EditProfileInputWidget extends StatefulWidget {
  const EditProfileInputWidget({super.key});

  @override
  State<EditProfileInputWidget> createState() => _EditProfileInputWidgetState();
}

class _EditProfileInputWidgetState extends State<EditProfileInputWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        24.hS,
        EditProfileTextField(
            label: "name".tr(),
            hint: "enter_name".tr(),
            onChanged: (val){}
        ),
        12.hS,
        EditProfileTextField(
            label: "email".tr(),
            hint: "enter_email".tr(),
            onChanged: (val){}
        ),
        12.hS,
        EditProfileTextField(
            label: "city".tr(),
            hint: "enter_city".tr(),
            onChanged: (val){}
        ),
        24.hS,
      ],
    );
  }
}
