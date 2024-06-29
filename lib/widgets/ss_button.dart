import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SsButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final double? height;
  final double? width;
  final Color backgroundColor;
  final Color textColor;
  final bool enable;
  final bool loading;
  const SsButton({
    required this.text,
    required this.onTap,
    this.height,
    this.width,
    super.key,
    this.backgroundColor = Colors.black,
    this.textColor = Colors.white,
    this.enable = true,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: enable ? onTap : null,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: enable ? backgroundColor : Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 16),
        child: loading
            ? const CircularProgressIndicator()
            : Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                ),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
