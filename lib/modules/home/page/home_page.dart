import 'package:auto_route/auto_route.dart';
import 'package:coyote/modules/home/widget/card_debt.dart';
import 'package:coyote/routes/app_router.dart';
import 'package:coyote/routes/app_router.gr.dart';
import 'package:coyote/widgets/ss_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SsScaffold(
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.add_circle_outline,
            size: 30.sp,
          ),
          onPressed: () {
            appRouter.push(const NewLoanRoute());
          },
        ),
        PopupMenuButton<String>(
          onSelected: (String result) {
            switch (result) {
              case '1':
                appRouter.push(const ClientsRoute());
                break;
              case '2':
                break;
              case '3':
                break;
              case '4':
                break;
              case '5':
                break;
              case '6':
                break;
              case '7':
                break;
              case '8':
                appRouter.push(const ExpensesRoute());
                break;
              case '9':
                break;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: '1',
              child: Text('Ver Clientes'),
            ),
            const PopupMenuItem<String>(
              value: '2',
              child: Text('Todas las Ventas'),
            ),
            const PopupMenuItem<String>(
              value: '3',
              child: Text('Ventas del Dia'),
            ),
            const PopupMenuItem<String>(
              value: '5',
              child: Text('Ver Caja'),
            ),
            const PopupMenuItem<String>(
              value: '6',
              child: Text('Datos del Dia'),
            ),
            const PopupMenuItem<String>(
              value: '7',
              child: Text('Gastos Registrados'),
            ),
            const PopupMenuItem<String>(
              value: '8',
              child: Text('Agregar Gastos'),
            ),
            const PopupMenuItem<String>(
              value: '9',
              child: Text('Registrar Retiro'),
            ),
          ],
        ),
      ],
      title: 'Home',
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemBuilder: (context, index) {
          return CardDebt(
            rout: index,
          );
        },
        itemCount: 10,
      ),
    );
  }
}
