import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myvegiz_flutter/src/configs/injector/injector.dart';
import 'package:myvegiz_flutter/src/core/extensions/string_validator_extension.dart';
import '../../core/extensions/integer_sizedbox_extension.dart';
import '../../core/themes/app_color.dart';


class SearchTextField<T> extends StatefulWidget {
  final String hint;
  final bool? isSecure;
  final List<TextInputFormatter>? inputFormat;
  final void Function(String)? onChanged;
  final String? initialValue;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final TextCapitalization? textCapitalization;
  final TextEditingController? controller; // ✅ NEW

  const SearchTextField({
    super.key,
    required this.hint,
    required this.onChanged,
    this.isSecure,
    this.readOnly,
    this.inputFormat,
    this.initialValue,
    this.keyboardType,
    this.textCapitalization,
    this.controller, // ✅ NEW
  });

  @override
  State<SearchTextField<T>> createState() => _SearchTextFieldState<T>();
}

class _SearchTextFieldState<T> extends State<SearchTextField<T>> {
  bool _isVisible = true;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ??
        TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      child: TextFormField(
        controller: _controller, // ✅ USE CONTROLLER
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: widget.isSecure ?? false ? _isVisible : false,
        cursorColor: AppColor.green,
        onChanged: widget.onChanged,
        style: Theme.of(context).textTheme.bodyMedium,
        textCapitalization:
        widget.textCapitalization ?? TextCapitalization.none,
        inputFormatters: widget.inputFormat,
        keyboardType: widget.keyboardType,
        readOnly: widget.readOnly ?? false,
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          label: Text(
            widget.hint,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColor.hintText),
          ),
          prefixIcon:
          Icon(Icons.search_rounded, color: AppColor.hintText),
          suffixIcon: widget.isSecure ?? false
              ? IconButton(
            onPressed: _toggleVisibility,
            icon: Icon(
              _isVisible
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
            ),
          )
              : null,
          filled: true,
          fillColor: AppColor.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

