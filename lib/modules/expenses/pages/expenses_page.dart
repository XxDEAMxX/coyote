import 'package:auto_route/auto_route.dart';
import 'package:coyote/widgets/ss_app_bar.dart';
import 'package:coyote/widgets/ss_button.dart';
import 'package:coyote/widgets/ss_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class ExpensesPage extends StatelessWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SsScaffold(
        title: 'Registrar Gasto',
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Concepto',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ),
              const SsTextInput(
                hintText: 'Descripcion',
              ),
              SizedBox(height: 20.h),
              Text(
                'Valor',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ),
              SsTextInput(
                hintText: 'Valor Gastos',
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              SizedBox(height: 20.h),
              SsButton(
                textColor: Colors.black,
                width: double.infinity,
                backgroundColor: Colors.green,
                text: 'Registrar Gasto',
                onTap: () {},
              )
            ],
          ),
        ));
  }
}
