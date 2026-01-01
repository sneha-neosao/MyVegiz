import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector.dart';
import 'package:myvegiz_flutter/src/core/extensions/integer_sizedbox_extension.dart';
import 'package:myvegiz_flutter/src/features/register/widgets/create_account_text_field_widget.dart';

class CreateAccountInputWidget extends StatefulWidget {
  const CreateAccountInputWidget({super.key});

  @override
  State<CreateAccountInputWidget> createState() => _CreateAccountInputWidgetState();
}

class _CreateAccountInputWidgetState extends State<CreateAccountInputWidget> {
  late RegistrationBloc formBloc;

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<RegistrationFormBloc>();

    return Column(
      children: [
        24.hS,
        CreateAccountTextField<RegistrationFormBloc>(
            label: "name".tr(),
            hint: "enter_name".tr(),
            onChanged: (val){
              print("name entered: ${val}");
              formBloc.add(RegistrationFormNameChangedEvent(val));
            }
        ),
        12.hS,
        CreateAccountTextField<RegistrationFormBloc>(
            label: "mobile_number".tr(),
            hint: "enter_mobile_number".tr(),
            onChanged: (val){
              print("mobile entered: ${val}");
              formBloc.add(RegistrationFormContactNumberChangedEvent(val));
            }
        ),
        12.hS,
        CreateAccountTextField<RegistrationFormBloc>(
            label: "email".tr(),
            hint: "enter_email".tr(),
            onChanged: (val){
              print("email entered: ${val}");
              formBloc.add(RegistrationFormEmailChangedEvent(val));
            }
        ),
        12.hS,
        // CreateAccountTextField(
        //     label: "city".tr(),
        //     hint: "enter_city".tr(),
        //     onChanged: (val){}
        // ),
        // CreateAccountDropdown<CityModel>(
        //   label: "city".tr(),
        //   hint: "enter_city".tr(),
        //   items: cityList, // List<CityModel>
        //   value: selectedCity,
        //   itemLabel: (city) => city.cityName ?? "",
        //   onChanged: (city) {
        //     setState(() {
        //       selectedCity = city;
        //     });
        //
        //     // 🔑 City code for API
        //     final cityCode = city?.code;
        //     print("Selected City Code: $cityCode");
        //   },
        // ),
        // 24.hS,
      ],
    );
  }
}
