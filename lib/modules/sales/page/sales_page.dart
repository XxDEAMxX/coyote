import 'package:auto_route/auto_route.dart';
import 'package:coyote/data/payments_database.dart';
import 'package:coyote/models/payment_model.dart';
import 'package:coyote/type/date_time_extension.dart';
import 'package:coyote/type/double_extension.dart';
import 'package:coyote/widgets/ss_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

@RoutePage()
class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  List<PaymentModel> payments = [];

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
                return SsCard(date: date, totalPaid: totalPaid);
              },
            );
          }
        },
      ),
    );
  }

  Future<Map<String, double>> _getPaymentSumsByDate() async {
    Map<String, double> paymentSumsByDate = {};
    DateFormat formatter = DateFormat('yyyy-MM-dd');

    for (var payment in payments) {
      if (payment.updatedAt != null) {
        String formattedDate = formatter.format(payment.updatedAt!);
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

class SsCard extends StatelessWidget {
  const SsCard({
    super.key,
    required this.date,
    required this.totalPaid,
  });

  final String date;
  final double totalPaid;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      padding: const EdgeInsets.all(16),
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
                'Total:  ${DoubleExtension().toMoney(totalPaid)}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
