import 'package:auto_route/auto_route.dart';
import 'package:coyote/modules/debt/widget/card_payments.dart';
import 'package:coyote/widgets/ss_app_bar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class DebtPage extends StatelessWidget {
  const DebtPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SsScaffold(
      title: 'Pagos',
      body: ListView.builder(
        itemBuilder: (context, index) {
          return CardPayments(
            rout: index,
          );
        },
        itemCount: 10,
      ),
    );
  }
}
