import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

Duration ssNotificationDuration = const Duration(seconds: 3);

abstract class SsNotification {
  static void setDuration(Duration duration) {
    ssNotificationDuration = duration;
  }

  static void error(String message) {
    show(
      text: message,
      backgroundColor: Colors.red,
      icon: Icons.error_rounded,
      foregroundColor: Colors.white,
    );
  }

  static void warning(String message) {
    show(
      text: message,
      backgroundColor: Colors.orange,
      icon: Icons.warning_rounded,
      foregroundColor: Colors.black,
    );
  }

  static void info(String message) {
    show(
      text: message,
      backgroundColor: Colors.blue,
      icon: Icons.info_rounded,
      foregroundColor: Colors.black,
    );
  }

  static void success(String message) {
    show(
      text: message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle_rounded,
      foregroundColor: Colors.black,
    );
  }

  static void showRemote({
    required String title,
    required String? body,
    required VoidCallback onTap,
  }) {
    unawaited(
      SmartDialog.showToast(
        '',
        displayTime: ssNotificationDuration,
        consumeEvent: true,
        clickMaskDismiss: true,
        animationTime: Duration.zero,
        alignment: Alignment.bottomCenter,
        builder: (context) {
          return GestureDetector(
            onTap: () {
              SmartDialog.dismiss(status: SmartStatus.allToast);
              onTap();
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 20.h),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              constraints: BoxConstraints(
                maxWidth: 0.9.sw,
                minHeight: 60.sp,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(1.sp),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange,
                    blurRadius: 4.sp,
                    offset: Offset(0, 4.sp),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.warning_rounded, color: Colors.orange),
                  SizedBox(width: 10.w),
                  Container(
                    constraints: BoxConstraints(
                      maxWidth: 0.6.sw,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 12.sp,
                            color: Colors.grey,
                          ),
                        ),
                        if (body != null)
                          Text(
                            body,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  static void show({
    String? text,
    Widget? content,
    Color? backgroundColor,
    Color? foregroundColor,
    IconData? icon,
    double? height,
  }) {
    final minHeight = height ?? 80.h;
    unawaited(
      SmartDialog.showToast(
        '',
        displayTime: ssNotificationDuration,
        animationTime: Duration.zero,
        builder: (context) {
          return Container(
            width: 1.sw,
            height: minHeight,
            padding: EdgeInsets.only(bottom: 20.h),
            child: Center(
              child: Container(
                padding: EdgeInsets.all(8.w),
                width: double.infinity,
                height: minHeight,
                decoration: BoxDecoration(
                  color: (backgroundColor ?? Colors.white).withOpacity(0.95),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: content ??
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (icon != null)
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15.w,
                                ),
                                child: Icon(
                                  icon,
                                  color: foregroundColor ?? Colors.black,
                                  size: 30.h,
                                ),
                              ),
                            if (text != null)
                              Expanded(
                                child: Text(
                                  text,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12.sp,
                                    color: foregroundColor ?? Colors.black,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
              ),
            ),
          );
        },
      ),
    );
  }
}
