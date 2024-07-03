import 'package:coyote/models/payment_model.dart';
import 'package:coyote/modules/debt/widget/payment_dialog.dart';
import 'package:coyote/type/date_time_extension.dart';
import 'package:coyote/type/double_extension.dart';
import 'package:coyote/widgets/ss_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardPayments extends StatelessWidget {
  final PaymentModel payment;
  final bool toPay;
  const CardPayments({
    required this.payment,
    required this.toPay,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double balance = payment.amountToBePaid! - payment.amountPaid!;
    final int mora = DateTime.now().difference(payment.datePayment!).inDays;
    return InkWell(
      onTap: () {
        if (balance > 0 && toPay) {
          SsDialog.show(
            context: context,
            content: PaymentDialog(
              payment: payment,
            ),
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
            width: 0.5,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const Text(
                  'Cuota #:',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
                Center(
                  child: Text(
                    '${payment.quotaNumber}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  '${payment.id}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'Dias mora:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                const Text(
                  'valor:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white),
                    ),
                  ),
                  child: const Text(
                    'Saldo:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                const Text(
                  'Fecha vence:',
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 12,
                  ),
                ),
                const Text(
                  'fecha de pago:',
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  balance <= 0
                      ? '0'
                      : mora < 0
                          ? '0'
                          : mora.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                Text(
                  DoubleExtension().toMoneySim(payment.amountToBePaid),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.white),
                    ),
                  ),
                  child: Text(
                    DoubleExtension().toMoneySim(balance),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(payment.datePayment!),
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 12,
                  ),
                ),
                Text(
                  DateTimeExtension().toHumanize(payment.updatedAt),
                  style: const TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Icon(
              balance <= 0
                  ? Icons.file_download_done
                  : toPay
                      ? Icons.payments_outlined
                      : Icons.lock,
              color: balance <= 0
                  ? Colors.greenAccent
                  : toPay
                      ? mora > 2
                          ? Colors.red
                          : Colors.blue
                      : Colors.orange,
              size: 60,
            )
          ],
        ),
      ),
    );
  }
}
