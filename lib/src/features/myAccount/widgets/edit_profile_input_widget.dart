import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/core/session/session_manager.dart';
import 'package:myvegiz_flutter/src/features/myAccount/bloc/edit_profile_form_bloc/edit_profile_form_bloc.dart';
import 'package:myvegiz_flutter/src/features/myAccount/widgets/edit_profile_text_field_widget.dart';

import '../../../configs/injector/injector.dart';

class EditProfileInputWidget extends StatefulWidget {

  const EditProfileInputWidget({super.key});

  @override
  State<EditProfileInputWidget> createState() => _EditProfileInputWidgetState();
}

class _EditProfileInputWidgetState extends State<EditProfileInputWidget> {
  late EditProfileFormBloc formBloc;

  String? name;
  String? email;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    final user = await SessionManager.getUserSessionInfo(); // returns UserModel
    if (user != null) {
      // Prefill form bloc with saved values
      setState(() {
        name = user.name;
        email = user.emailId;
      });
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
            initialValue: name,
            onChanged: (val){
              print("name entered: ${val}");
              formBloc.add(EditProfileFormNameChangedEvent(val));
            }
        ),
        12.hS,
        EditProfileTextField<EditProfileFormBloc>(
            label: "email".tr(),
            hint: "enter_email".tr(),
            initialValue: email,
            onChanged: (val){
              print("name entered: ${val}");
              formBloc.add(EditProfileFormEmailChangedEvent(val));
            }
        ),
        12.hS,
      ],
    );
  }
}
