// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class SsDialog {
  static Future<void> show({
    required BuildContext context,
    required Widget content,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: 0.9.sw,
              maxHeight: 0.9.sh,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: Stack(
              children: [
                content,
              ],
            ),
          ),
        );
      },
    );
  }

  static Future<void> showConfirm({
    required BuildContext context,
    required String text,
    String? confirmText,
    String? cancelText,
    Future<void>? Function()? onConfirm,
    Future<void>? Function()? onCancel,
  }) async {
    bool loading = false;
    final width = max(confirmText?.length ?? 0, cancelText?.length ?? 0) * 15.0;
    await showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            width: max(width, 0.8.sw),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: Stack(
                children: [
                  StatefulBuilder(builder: (context, setState) {
                    return Material(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20.w),
                            child: Text(
                              text,
                              style: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          if (loading)
                            Padding(
                              padding: EdgeInsets.only(bottom: 30.h),
                              child: const CircularProgressIndicator(),
                            ),
                          if (confirmText != null && !loading)
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  loading = true;
                                });
                                if (onConfirm != null) {
                                  await onConfirm();
                                }
                                try {
                                  Navigator.pop(context);
                                } catch (e) {
                                  loading = false;
                                }
                              },
                              child: Column(
                                children: [
                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 0.5,
                                    height: 0.5,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: Text(
                                      confirmText,
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (cancelText != null && !loading)
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  loading = true;
                                });
                                if (onCancel != null) {
                                  await onCancel();
                                }
                                try {
                                  Navigator.pop(context);
                                } catch (e) {
                                  loading = false;
                                }
                              },
                              child: Column(
                                children: [
                                  const Divider(
                                    color: Colors.grey,
                                    thickness: 0.5,
                                    height: 0.5,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: Text(
                                      cancelText,
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Close extends StatelessWidget {
  const _Close();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 7.sp,
      right: 7.sp,
      child: SizedBox(
        width: 20.sp,
        height: 20.sp,
        child: IconButton(
          padding: EdgeInsets.all(2.sp),
          color: Colors.grey,
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(Colors.greenAccent),
          ),
          onPressed: () => Navigator.pop(context),
          icon: const FittedBox(
            child: Icon(Icons.close_rounded),
          ),
        ),
      ),
    );
  }
}
