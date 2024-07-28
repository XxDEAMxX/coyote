import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SsScaffold extends StatelessWidget {
  final Widget body;
  final String? titleAppBar;
  final VoidCallback? onBack;
  final bool showBottomNavigationBar;
  final bool solidBackground;
  final bool showHelp;
  final bool bottomSafeArea;
  final bool topSafeArea;
  final List<Widget>? actions;

  const SsScaffold({
    required this.body,
    this.titleAppBar,
    this.onBack,
    this.showBottomNavigationBar = false,
    this.solidBackground = false,
    this.showHelp = false,
    this.bottomSafeArea = true,
    this.topSafeArea = true,
    this.actions,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final showAppBar = titleAppBar != null || onBack != null || showHelp;
    final Color statusBarColor = showAppBar ? Colors.black : Colors.transparent;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: statusBarColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: showAppBar
            ? AppBar(
                title: _Title(
                  onBack: onBack,
                  titleAppBar: titleAppBar,
                  showHelp: showHelp,
                ),
                titleSpacing: 0,
                surfaceTintColor: statusBarColor,
                backgroundColor: statusBarColor,
                elevation: 0,
                automaticallyImplyLeading: false,
                toolbarHeight: 50.w,
                actions: actions,
              )
            : null,
        backgroundColor: Colors.brown,
        body: Container(
          height: 1.sh,
          width: 1.sw,
          decoration: BoxDecoration(
            color: solidBackground ? Colors.amber : Colors.white,
          ),
          child: SafeArea(
            top: topSafeArea,
            bottom: bottomSafeArea,
            child: body,
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.onBack,
    required this.titleAppBar,
    required this.showHelp,
  });

  final VoidCallback? onBack;
  final String? titleAppBar;
  final bool showHelp;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (onBack != null) _Back(onBack: onBack) else SizedBox(width: 60.w),
        if (titleAppBar != null)
          Expanded(
            child: Text(
              titleAppBar!,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        SizedBox(width: 60.w),
      ],
    );
  }
}

class _Back extends StatelessWidget {
  final VoidCallback? onBack;

  const _Back({
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBack,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 2.sp, left: 2.w),
            child: Icon(
              Icons.chevron_left,
              color: Colors.white,
              size: 28.sp,
            ),
          ),
        ],
      ),
    );
  }
}
