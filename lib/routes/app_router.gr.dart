// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:coyote/models/client_model.dart' as _i9;
import 'package:coyote/modules/clients/page/cliente_new_page.dart' as _i1;
import 'package:coyote/modules/clients/page/clients_page.dart' as _i2;
import 'package:coyote/modules/debt/page/debt_page.dart' as _i3;
import 'package:coyote/modules/expenses/pages/expenses_page.dart' as _i4;
import 'package:coyote/modules/home/page/home_page.dart' as _i5;
import 'package:coyote/modules/new_loan/page/new_loan_page.dart' as _i6;
import 'package:flutter/material.dart' as _i8;

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
      final args = routeData.argsAs<DebtRouteArgs>();
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.DebtPage(
          loanId: args.loanId,
          key: args.key,
        ),
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
      final args = routeData.argsAs<NewLoanRouteArgs>(
          orElse: () => const NewLoanRouteArgs());
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i6.NewLoanPage(
          key: args.key,
          client: args.client,
        ),
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
class DebtRoute extends _i7.PageRouteInfo<DebtRouteArgs> {
  DebtRoute({
    required int loanId,
    _i8.Key? key,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          DebtRoute.name,
          args: DebtRouteArgs(
            loanId: loanId,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'DebtRoute';

  static const _i7.PageInfo<DebtRouteArgs> page =
      _i7.PageInfo<DebtRouteArgs>(name);
}

class DebtRouteArgs {
  const DebtRouteArgs({
    required this.loanId,
    this.key,
  });

  final int loanId;

  final _i8.Key? key;

  @override
  String toString() {
    return 'DebtRouteArgs{loanId: $loanId, key: $key}';
  }
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
class NewLoanRoute extends _i7.PageRouteInfo<NewLoanRouteArgs> {
  NewLoanRoute({
    _i8.Key? key,
    _i9.ClientModel? client,
    List<_i7.PageRouteInfo>? children,
  }) : super(
          NewLoanRoute.name,
          args: NewLoanRouteArgs(
            key: key,
            client: client,
          ),
          initialChildren: children,
        );

  static const String name = 'NewLoanRoute';

  static const _i7.PageInfo<NewLoanRouteArgs> page =
      _i7.PageInfo<NewLoanRouteArgs>(name);
}

class NewLoanRouteArgs {
  const NewLoanRouteArgs({
    this.key,
    this.client,
  });

  final _i8.Key? key;

  final _i9.ClientModel? client;

  @override
  String toString() {
    return 'NewLoanRouteArgs{key: $key, client: $client}';
  }
}
