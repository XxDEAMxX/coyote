// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:coyote/modules/clients/page/cliente_new_page.dart' as _i1;
import 'package:coyote/modules/clients/page/clients_page.dart' as _i2;
import 'package:coyote/modules/debt/page/debt_page.dart' as _i3;
import 'package:coyote/modules/expenses/pages/expenses_page.dart' as _i4;
import 'package:coyote/modules/home/page/home_page.dart' as _i5;
import 'package:coyote/modules/new_loan/page/new_loan_page.dart' as _i6;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    ClientNewRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ClientNewPage(),
      );
    },
    ClientsRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ClientsPage(),
      );
    },
    DebtRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.DebtPage(),
      );
    },
    ExpensesRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.ExpensesPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.HomePage(),
      );
    },
    NewLoanRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.NewLoanPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.ClientNewPage]
class ClientNewRoute extends _i7.PageRouteInfo<void> {
  const ClientNewRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ClientNewRoute.name,
          initialChildren: children,
        );

  static const String name = 'ClientNewRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ClientsPage]
class ClientsRoute extends _i7.PageRouteInfo<void> {
  const ClientsRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ClientsRoute.name,
          initialChildren: children,
        );

  static const String name = 'ClientsRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.DebtPage]
class DebtRoute extends _i7.PageRouteInfo<void> {
  const DebtRoute({List<_i7.PageRouteInfo>? children})
      : super(
          DebtRoute.name,
          initialChildren: children,
        );

  static const String name = 'DebtRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.ExpensesPage]
class ExpensesRoute extends _i7.PageRouteInfo<void> {
  const ExpensesRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ExpensesRoute.name,
          initialChildren: children,
        );

  static const String name = 'ExpensesRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.NewLoanPage]
class NewLoanRoute extends _i7.PageRouteInfo<void> {
  const NewLoanRoute({List<_i7.PageRouteInfo>? children})
      : super(
          NewLoanRoute.name,
          initialChildren: children,
        );

  static const String name = 'NewLoanRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
