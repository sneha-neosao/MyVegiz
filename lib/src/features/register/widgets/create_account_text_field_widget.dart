import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector.dart';
import 'package:myvegiz_flutter/src/core/extensions/string_validator_extension.dart';
import '../../../core/extensions/integer_sizedbox_extension.dart';
import '../../../core/themes/app_color.dart';


class CreateAccountTextField<T> extends StatefulWidget {
  final String label;
  final String hint;
  final bool? isSecure;
  final List<TextInputFormatter>? inputFormat;
  final void Function(String)? onChanged;
  final String? initialValue;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final TextCapitalization? textCapitalization;

  const CreateAccountTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.onChanged,
    this.isSecure,
    this.readOnly,
    this.inputFormat,
    this.initialValue,
    this.keyboardType,
    this.textCapitalization,
  });

  @override
  State<CreateAccountTextField<T>> createState() => _CreateAccountTextFieldState<T>();
}

class _CreateAccountTextFieldState<T> extends State<CreateAccountTextField<T>> {
  bool _isVisible = true;

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<T>();
    return  Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 4.h,
        ),
        child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColor.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              8.hS,
              TextFormField(
                initialValue: widget.initialValue,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: widget.isSecure ?? false ? _isVisible : false,
                cursorColor: AppColor.green,
                onChanged: widget.onChanged,
                style:Theme.of(context).textTheme.bodyMedium,
                textCapitalization: widget.textCapitalization??TextCapitalization.none,
                inputFormatters: widget.inputFormat,
                keyboardType: widget.keyboardType,
                readOnly: widget.readOnly??false,
                validator: (val) {
                  if (formBloc is RegistrationFormBloc) {
                    if(widget.label == "name".tr() &&
                        val!.isEmpty) {
                      return "please_enter_name".tr();
                    }else if(widget.label == "mobile_number".tr() &&
                        val!.isEmpty) {
                      return "please_enter_mobile_number".tr();
                    }else if (widget.label == "mobile_number".tr() &&
                        !val!.isMobileNumberValid){
                      return "please_enter_valid_mobile_number".tr();
                    }else if(widget.label == "email".tr() &&
                        val!.isEmpty) {
                      return "please_enter_email".tr();
                    }else if (widget.label == "email".tr() &&
                        !val!.isEmailValid){
                      return "please_enter_valid_email".tr();
                    }else if(widget.label == "city".tr() &&
                        val!.isEmpty) {
                      return "please_select_city".tr();
                    }
                  }

                  return null;
                },
                decoration: InputDecoration(
                  errorMaxLines: 3,
                  errorStyle:Theme.of(context).textTheme.bodySmall?.copyWith(fontSize:10,fontStyle:FontStyle.italic,fontWeight: FontWeight.w300,color: AppColor.brightRed),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  label: Text(widget.hint,style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColor.hintText)),
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  suffixIcon: widget.isSecure ?? false
                      ? IconButton(
                    onPressed: () {
                      _toggleVisibility();
                    },
                    icon: Icon(
                      _isVisible
                          ? Icons.visibility_rounded
                          : Icons.visibility_off_rounded,
                    ),
                    splashRadius: 20.r,
                  )
                      : null,
                  filled: true,
                  fillColor: AppColor.white,
                  border: OutlineInputBorder( borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide.none, ),
                  enabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide.none, ),
                  focusedBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide.none, ),
                  disabledBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide.none, ),
                  errorBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide.none, ),
                  focusedErrorBorder: OutlineInputBorder( borderRadius: BorderRadius.circular(8.r), borderSide: BorderSide.none, ),
                ),
              ),
            ]
        )
    );
  }
}
