import 'package:flutter/material.dart';
import 'package:myvegiz_flutter/src/core/themes/app_color.dart';

class AppButtonWidget extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;
  final bool enabled;

  const AppButtonWidget({
    super.key,
    required this.onPressed,
    required this.label,
    this.enabled = true,
  });

  @override
  State<AppButtonWidget> createState() => _AppButtonWidgetState();
}

class _AppButtonWidgetState extends State<AppButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 51,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.enabled ? widget.onPressed : null,
        style: ButtonStyle(
          // remove default background so gradient shows
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColor.green, AppColor.darkGreen],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              widget.label,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color: AppColor.white,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
