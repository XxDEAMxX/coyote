import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SsCard extends StatelessWidget {
  const SsCard({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 0.5,
        ),
        // boxShadow: [
        // BoxShadow(
        // color: Colors.grey.withOpacity(0.5),
        // spreadRadius: 1,
        // blurRadius: 3,
        // offset: const Offset(0, ),
        // ),
        // ],
      ),
      // margin: EdgeInsets.symmetric(
      //   vertical: 8.h,
      //   horizontal: 16.w,
      // ),
      padding: EdgeInsets.all(16.sp),
      child: child,
    );
  }
}
