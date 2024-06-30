import 'package:auto_route/auto_route.dart';
import 'package:coyote/modules/clients/clients_router.dart';
import 'package:coyote/modules/debt/debt_router.dart';
import 'package:coyote/modules/expenses/expenses_router.dart';
import 'package:coyote/modules/home/home_router.dart';
import 'package:coyote/modules/new_loan/new_loan_router.dart';
import 'package:coyote/modules/sales/sales_router.dart';
import 'package:coyote/routes/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        ...dabtRoutes,
        ...homeRoutes,
        ...expansesRoutes,
        ...newLoanRoutes,
        ...clientsRoutes,
        ...salesRoutes,
      ];

  bool contain(PageInfo page) {
    return appRouter.stack.any((e) => e.name == page.name);
  }

  bool currentIs(PageInfo page) {
    return appRouter.current.name == page.name;
  }

  // Future<void> pushAndPopUntilTo(PageRouteInfo page) async {
  //   await appRouter.pushAndPopUntil(
  //     page,
  //     predicate: (route) => route.settings.name == HomeRoute.name,
  //   );
  // }

  // Future<void> popUntilHome() async {
  //   await appRouter.pushAndPopUntil(
  //     const HomeRoute(),
  //     predicate: (route) => false,
  //   );
  // }
}

class SsRoute extends CustomRoute {
  SsRoute({
    required super.page,
    super.children,
    super.guards,
  }) : super(
          transitionsBuilder: TransitionsBuilders.noTransition,
        );
}

final appRouter = AppRouter();
