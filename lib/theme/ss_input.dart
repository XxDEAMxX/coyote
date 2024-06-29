import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextStyle inputTextStyle(bool enabled) {
  return TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: enabled ? Colors.grey : Colors.blueGrey,
  );
}

InputDecoration inputDecoration({
  String? hintText,
  String? labelText,
  Widget? prefixIcon,
  Widget? suffixIcon,
  bool isDropDown = false,
}) {
  return InputDecoration(
    errorMaxLines: 3,
    hintText: hintText,
    labelText: labelText,
    prefixIcon: prefixIcon,
    suffixIcon: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.sp),
      child: suffixIcon,
    ),
    contentPadding: EdgeInsets.only(
      left: 15.sp,
      right: 15.sp,
      top: 10.sp,
      bottom: 10.sp,
    ),
    prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
    suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
    border: inputBorder,
    disabledBorder: _borderDisabled,
    enabledBorder: inputBorder,
    focusedBorder: inputBorder,
    errorBorder: _borderError,
    focusedErrorBorder: _borderError,
    filled: true,
    fillColor: Colors.white,
    alignLabelWithHint: true,
    hintStyle: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: Colors.grey,
      height: 0.8,
    ),
    labelStyle: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w400,
      color: Colors.grey,
    ),
    errorStyle: TextStyle(
      fontSize: 10.sp,
      fontWeight: FontWeight.w400,
      color: Colors.grey,
      height: 0.8,
    ),
  );
}

OutlineInputBorder get inputBorder {
  return OutlineInputBorder(
    gapPadding: 0,
    borderRadius: BorderRadius.circular(6.r),
    borderSide: const BorderSide(
      color: Colors.grey,
      width: 1.2,
    ),
  );
}

OutlineInputBorder get _borderError {
  return inputBorder.copyWith(
    borderSide: const BorderSide(
      color: Colors.grey,
      width: 1.2,
    ),
  );
}

OutlineInputBorder get _borderDisabled {
  return inputBorder.copyWith(
    borderSide: const BorderSide(
      color: Colors.grey,
      width: 1.2,
    ),
  );
}
