import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/session/session_manager.dart';
import 'package:myvegiz_flutter/src/features/myAccount/bloc/edit_profile_form_bloc/edit_profile_form_bloc.dart';
import 'package:myvegiz_flutter/src/features/myAccount/widgets/edit_profile_text_field_widget.dart';
import 'package:myvegiz_flutter/src/remote/models/profile_details_model/profile_details_response.dart';

class EditProfileInputWidget extends StatefulWidget {
  final UserProfile? userData;

  const EditProfileInputWidget({super.key, required this.userData});

  @override
  State<EditProfileInputWidget> createState() => _EditProfileInputWidgetState();
}

class _EditProfileInputWidgetState extends State<EditProfileInputWidget> {
  String? name;
  String? email;

  @override
  void initState() {
    super.initState();
    _prefillFormBloc();
  }

  Future<void> _prefillFormBloc() async {
    final formBloc = context.read<EditProfileFormBloc>();

    // Prefer API-provided userData, fallback to session
    final user = widget.userData ?? await SessionManager.getUserSessionInfo();

    if (user != null) {
      name = user.name;
      email = user.emailId;

      // Dispatch initial values to form bloc
      formBloc.add(EditProfileFormNameChangedEvent(user.name));
      formBloc.add(EditProfileFormEmailChangedEvent(user.emailId));
      formBloc.add(EditProfileFormCityCodeChangedEvent(user.cityCode));
      formBloc.add(EditProfileFormClientCodeChangedEvent(user.code));
    }
  }

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<EditProfileFormBloc>();

    return Column(
      children: [
        24.hS,
        EditProfileTextField<EditProfileFormBloc>(
          label: "name".tr(),
          hint: "enter_name".tr(),
          initialValue: name ?? widget.userData?.name ?? '',
          onChanged: (val) {
            formBloc.add(EditProfileFormNameChangedEvent(val));
          },
        ),
        12.hS,
        EditProfileTextField<EditProfileFormBloc>(
          label: "email".tr(),
          hint: "enter_email".tr(),
          initialValue: email ?? widget.userData?.emailId ?? '',
          onChanged: (val) {
            formBloc.add(EditProfileFormEmailChangedEvent(val));
          },
        ),
        12.hS,
      ],
    );
  }
}
