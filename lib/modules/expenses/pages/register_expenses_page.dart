import 'package:auto_route/auto_route.dart';
import 'package:coyote/data/expenses_database.dart';
import 'package:coyote/models/expense_model.dart';
import 'package:coyote/routes/app_router.dart';
import 'package:coyote/type/text_input_format_extension.dart';
import 'package:coyote/widgets/ss_app_bar.dart';
import 'package:coyote/widgets/ss_button.dart';
import 'package:coyote/widgets/ss_notification.dart';
import 'package:coyote/widgets/ss_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class RegisterExpensesPage extends StatefulWidget {
  const RegisterExpensesPage({super.key});

  @override
  State<RegisterExpensesPage> createState() => _RegisterExpensesPageState();
}

class _RegisterExpensesPageState extends State<RegisterExpensesPage> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return SsScaffold(
        title: 'Registrar Gasto',
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Concepto',
                style: TextStyle(
                  fontSize: 20.sp,
                ),
              ),
              SsTextInput(
                controller: _descriptionController,
                hintText: 'Descripcion',
                onChanged: (p0) {
                  setState(() {});
                },
              ),
              SizedBox(height: 20.h),
              Text(
                'Valor',
                style: TextStyle(
                  fontSize: 20.sp,
                ),
              ),
              SsTextInput(
                hintText: 'Valor Gastos',
                inputFormatters: <TextInputFormatter>[
                  NumberAndDotTextInputFormatter()
                ],
                controller: _amountController,
                keyboardType: TextInputType.number,
                onChanged: (p0) {
                  setState(() {});
                },
              ),
              SizedBox(height: 20.h),
              SsButton(
                enable: enable(),
                loading: loading,
                textColor: Colors.black,
                width: double.infinity,
                backgroundColor: Colors.green,
                text: 'Registrar Gasto',
                onTap: insertExpense,
              )
            ],
          ),
        ));
  }

  bool enable() {
    return _descriptionController.text.isNotEmpty &&
        _amountController.text.isNotEmpty &&
        !loading;
  }

  Future<void> insertExpense() async {
    if (_descriptionController.text.isEmpty) {
      SsNotification.warning('Ingresa un concepto');
      return;
    }
    if (_amountController.text.isEmpty) {
      SsNotification.warning('Ingresa un valor');
      return;
    }

    try {
      loading = true;
      setState(() {});
      final expense = ExpenseModel(
        description: _descriptionController.text,
        amount: double.parse(_amountController.text) * 1000,
        createAt: DateTime.now(),
      );
      await ExpensesDatabase.instance.insert(expense);
      appRouter.maybePop();
    } catch (e) {
      SsNotification.error('Error al registrar el gasto');
    } finally {
      loading = false;
      setState(() {});
    }
  }
}
