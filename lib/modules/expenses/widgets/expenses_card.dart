import 'package:coyote/data/client_database.dart';
import 'package:coyote/data/expenses_database.dart';
import 'package:coyote/data/loan_database.dart';
import 'package:coyote/models/expense_model.dart';
import 'package:coyote/models/loan_model.dart';
import 'package:coyote/type/double_extension.dart';
import 'package:coyote/widgets/ss_card.dart';
import 'package:coyote/widgets/ss_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataSales {
  final String name;
  final double amount;
  DataSales({
    required this.name,
    required this.amount,
  });
}

class ExpensesDataDialog extends StatefulWidget {
  const ExpensesDataDialog({
    super.key,
    required this.date,
  });

  final String date;

  @override
  State<ExpensesDataDialog> createState() => _ExpensesDataDialogState();
}

class _ExpensesDataDialogState extends State<ExpensesDataDialog> {
  List<ExpenseModel> loans = [];
  List<DataSales> dataPayments = [];
  bool loading = false;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchData();
    });
  }

  Future<void> fetchData() async {
    loading = true;
    if (mounted) {
      setState(() {});
    }
    try {
      loans = await ExpensesDatabase.instance.getExpensesByDate(widget.date);
      for (var payment in loans) {
        dataPayments.add(DataSales(
          name: payment.description!,
          amount: payment.amount!,
        ));
      }
    } catch (e) {
      SsNotification.error('Error al obtener los pagos');
    }
    loading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 25.h),
      child: loading
          ? const SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: dataPayments.length,
              itemBuilder: (context, index) {
                return SsCard(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(dataPayments[index].name)),
                    Expanded(
                      child: Text(
                        DoubleExtension()
                            .toMoneySim(dataPayments[index].amount),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ));
              },
            ),
    );
  }
}
