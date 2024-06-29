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
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      style: TextStyle(
        fontSize: 14.sp,
        color: textColor,
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
        border: const OutlineInputBorder(),
        hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
        hintText: hintText,
        labelStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
      ),
    );
  }
}
