import 'package:auto_route/auto_route.dart';
import 'package:coyote/data/payments_database.dart';
import 'package:coyote/models/payment_model.dart';
import 'package:coyote/modules/sales/widget/sales_data_dialog.dart';
import 'package:coyote/type/date_time_extension.dart';
import 'package:coyote/type/double_extension.dart';
import 'package:coyote/widgets/ss_app_bar.dart';
import 'package:coyote/widgets/ss_card.dart';
import 'package:coyote/widgets/ss_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  List<PaymentModel> payments = [];

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await fetchPayments();
    });
  }

  Future<void> fetchPayments() async {
    try {
      payments = await PaymentsDatabase.instance.getAllPayments();
    } catch (e) {
      print(e);
    } finally {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SsScaffold(
      title: 'Ventas',
      body: FutureBuilder<Map<String, double>>(
        future: _getPaymentSumsByDate(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay pagos registrados.'));
          } else {
            final paymentSumsByDate = snapshot.data!;
            return ListView.builder(
              itemCount: paymentSumsByDate.length,
              itemBuilder: (context, index) {
                String date = paymentSumsByDate.keys.elementAt(index);
                double totalPaid = paymentSumsByDate[date]!;
                return InkWell(
                  onTap: () {
                    SsDialog.show(
                        context: context,
                        content: SalesDataDialog(
                          date: date,
                        ));
                  },
                  child: SsCard(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              date,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Total:  ${DoubleExtension().toMoneySim(totalPaid)}',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<Map<String, double>> _getPaymentSumsByDate() async {
    Map<String, double> paymentSumsByDate = {};

    for (var payment in payments) {
      if (payment.updatedAt != null) {
        String formattedDate =
            DateTimeExtension().toHumanize(payment.updatedAt!);
        if (paymentSumsByDate.containsKey(formattedDate)) {
          paymentSumsByDate[formattedDate] =
              paymentSumsByDate[formattedDate]! + payment.amountPaid!;
        } else {
          paymentSumsByDate[formattedDate] = payment.amountPaid!;
        }
      }
    }
    return paymentSumsByDate;
  }
}
