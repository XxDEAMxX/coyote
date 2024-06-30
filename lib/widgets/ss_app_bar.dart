import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SsScaffold extends StatelessWidget {
  final Widget body;
  final Color? backgroundColor;
  final String title;
  final List<Widget>? actions;
  final Color textColor;
  const SsScaffold({
    required this.body,
    this.backgroundColor,
    required this.title,
    this.textColor = Colors.black,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        iconTheme: IconThemeData(color: textColor),
        centerTitle: true,
        actions: actions,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
      body: body,
    );
  }
}
