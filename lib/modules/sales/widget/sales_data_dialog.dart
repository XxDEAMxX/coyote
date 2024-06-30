import 'package:coyote/data/client_database.dart';
import 'package:coyote/data/loan_database.dart';
import 'package:coyote/data/payments_database.dart';
import 'package:coyote/models/payment_model.dart';
import 'package:coyote/type/double_extension.dart';
import 'package:coyote/widgets/ss_card.dart';
import 'package:coyote/widgets/ss_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DataPayment {
  final String name;
  final double amount;
  DataPayment({
    required this.name,
    required this.amount,
  });
}

class SalesDataDialog extends StatefulWidget {
  const SalesDataDialog({
    super.key,
    required this.date,
  });

  final String date;

  @override
  State<SalesDataDialog> createState() => _SalesDataDialogState();
}

class _SalesDataDialogState extends State<SalesDataDialog> {
  List<PaymentModel> payments = [];
  List<DataPayment> dataPayments = [];
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
      payments = await PaymentsDatabase.instance.getPaymentsByDate(widget.date);
      for (var payment in payments) {
        final loan = await LoanDatabase.instance.getLoanById(payment.loanId!);
        final client = await ClientDatabase.instance.getClient(loan.clientId!);
        dataPayments.add(DataPayment(
          name: client.name!,
          amount: payment.amountPaid!,
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
                    Text(dataPayments[index].name),
                    Text(DoubleExtension()
                        .toMoneySim(dataPayments[index].amount)),
                  ],
                ));
              },
            ),
    );
  }
}
