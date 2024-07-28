import 'package:auto_route/auto_route.dart';
import 'package:coyote/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      final screenSize = MediaQuery.of(context).size;
      double width = screenSize.width;
      return ScreenUtilInit(
        designSize: Size(width, width * 2),
        fontSizeResolver: (fontSize, instance) {
          return FontSizeResolvers.width(fontSize, instance);
        },
        minTextAdapt: true,
        builder: (BuildContext context, Widget? child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            title: 'Coyote',
            routerConfig: appRouter.config(
              navigatorObservers: () => [
                FlutterSmartDialog.observer,
                AutoRouteObserver(),
              ],
            ),
            builder: FlutterSmartDialog.init(
              builder: (context, child) {
                child = MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: const TextScaler.linear(1.0),
                  ),
                  child: child ?? const SizedBox(),
                );

                return Center(
                  child: Container(
                    constraints: BoxConstraints(maxWidth: width),
                    child: child,
                  ),
                );
              },
            ),
          );
        },
      );
    });
  }
}
