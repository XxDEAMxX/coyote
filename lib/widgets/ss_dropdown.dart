import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SsDropdown<T> extends StatelessWidget {
  final List<T> options;
  final T? initialValue;
  final ValueChanged<T?>? onChanged;
  final dynamic Function(T item)? itemBuilder;
  final double? width;
  final String? hint;
  final bool enabled;

  final bool loading;

  const SsDropdown({
    required this.options,
    this.initialValue,
    this.onChanged,
    this.itemBuilder,
    this.width,
    this.hint,
    this.enabled = true,
    this.loading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.displayMedium!;
    T? selected = initialValue;
    return StatefulBuilder(builder: (context, setState) {
      return DropdownButtonFormField<T>(
        value: selected,
        isExpanded: true,
        icon: Icon(
          Icons.arrow_drop_down_sharp,
          size: 20.sp,
          color: Colors.grey,
        ),
        style: textStyle.copyWith(
          color: Colors.grey,
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
        ),
        hint: loading
            ? CircularProgressIndicator()
            : Text(
                hint ?? '',
                style: textStyle.copyWith(
                  color: Colors.grey,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
        borderRadius: BorderRadius.circular(6.r),
        decoration: InputDecoration(
          fillColor: Colors.grey.withOpacity(0.2),
          hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
          labelStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
        // decoration: inputDecoration(isDropDown: true).copyWith(
        //   constraints: BoxConstraints(
        //     maxWidth: width ?? double.infinity,
        //   ),
        // ),
        elevation: 1,
        onChanged: enabled
            ? (T? value) {
                setState(() {
                  selected = value;
                });
                onChanged?.call(value);
              }
            : null,
        selectedItemBuilder: (context) {
          return options.map((e) {
            if (loading) {
              return CircularProgressIndicator();
            }
            if (itemBuilder?.call(e) is Widget) {
              return itemBuilder!(e) as Widget;
            }
            return Text(
              itemBuilder?.call(e) ?? e.toString(),
              style: textStyle.copyWith(
                color: Colors.black,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            );
          }).toList();
        },
        items: options.map<DropdownMenuItem<T>>((value) {
          return DropdownMenuItem<T>(
            value: value,
            child: itemBuilder?.call(value) is Widget
                ? itemBuilder!(value)
                : Text(
                    itemBuilder?.call(value) ?? value.toString(),
                    style: textStyle.copyWith(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
          );
        }).toList(),
      );
    });
  }
}
