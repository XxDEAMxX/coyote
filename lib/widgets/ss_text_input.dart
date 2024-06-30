import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SsTextInput extends StatelessWidget {
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Color? textColor;
  final int? maxLines;
  final int? minLines;
  final Function(String)? onChanged;
  final bool enable;

  const SsTextInput({
    super.key,
    this.hintText,
    this.inputFormatters,
    this.controller,
    this.keyboardType,
    this.textColor,
    this.maxLines,
    this.minLines,
    this.onChanged,
    this.enable = true,
  });
  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.r),
      borderSide: const BorderSide(
        color: Colors.grey,
      ),
    );
    return TextField(
      onChanged: onChanged,
      style: TextStyle(
        fontSize: 15.sp,
        color: enable ? textColor : Colors.grey,
        fontWeight: FontWeight.w500,
      ),
      controller: controller,
      buildCounter: (context,
              {required currentLength,
              required isFocused,
              required maxLength}) =>
          null,
      minLines: minLines,
      maxLength: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        filled: !enable,
        fillColor: Colors.grey.withOpacity(0.2),
        disabledBorder: border,
        enabled: enable,
        border: border,
        hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
        hintText: hintText,
        labelStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
      ),
    );
  }
}
