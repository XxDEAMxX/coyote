import 'package:coyote/data/payments_database.dart';
import 'package:coyote/models/payment_model.dart';
import 'package:coyote/modules/debt/debt_provider.dart';
import 'package:coyote/modules/debt/widget/debt_payment_successful.dart';
import 'package:coyote/routes/app_router.dart';
import 'package:coyote/type/double_extension.dart';
import 'package:coyote/widgets/ss_button.dart';
import 'package:coyote/widgets/ss_dialog.dart';
import 'package:coyote/widgets/ss_notification.dart';
import 'package:coyote/widgets/ss_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentDialog extends ConsumerStatefulWidget {
  final PaymentModel payment;
  const PaymentDialog({
    required this.payment,
    super.key,
  });

  @override
  ConsumerState<PaymentDialog> createState() => _PaymentDialogState();
}

class _PaymentDialogState extends ConsumerState<PaymentDialog> {
  final TextEditingController _amountController = TextEditingController();
  double? balance;

  @override
  initState() {
    balance =
        (widget.payment.amountToBePaid! - widget.payment.amountPaid!).abs();
    final String amount = DoubleExtension().toMoney(balance);
    _amountController.text = amount.substring(0, amount.length - 4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      height: 0.3.sh,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Daniel Esteban Arevalo Martnez',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'cuota N°',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '${widget.payment.quotaNumber}',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SsTextInput(
            hintText: 'Monto',
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            keyboardType: TextInputType.number,
            controller: _amountController,
          ),
          SsButton(
            width: double.infinity,
            text: 'Pagar',
            onTap: () async {
              double amount = double.parse(_amountController.text) * 1000;
              double missing = amount;
              final DateTime now = DateTime.now();

              try {
                if (amount > balance!) {
                  await PaymentsDatabase.instance.update(
                    widget.payment.copyWith(
                      amountPaid: widget.payment.amountToBePaid!,
                      updatedAt: now,
                    ),
                    widget.payment.id!,
                  );
                  missing = missing - balance!;
                  final missingtmp = missing;
                  for (int i = 1;
                      i <
                          (missingtmp / widget.payment.amountToBePaid!).ceil() +
                              1;
                      i++) {
                    await PaymentsDatabase.instance.update(
                      widget.payment.copyWith(
                        amountPaid: (amount / balance!).ceil() - 1 == i
                            ? missing
                            : widget.payment.amountToBePaid,
                        updatedAt: now,
                      ),
                      widget.payment.id! + i,
                    );
                    missing = missing - widget.payment.amountToBePaid!;
                  }
                } else {
                  await PaymentsDatabase.instance.update(
                    widget.payment.copyWith(
                      amountPaid: amount + widget.payment.amountPaid!,
                      updatedAt: now,
                    ),
                    widget.payment.id!,
                  );
                }
                await ref
                    .read(debtProvider.notifier)
                    .getPayments(loanId: widget.payment.loanId!);
                await appRouter.maybePop();
                SsDialog.show(
                  context: context,
                  content: const DebtPaymentSuccessful(),
                );
              } catch (e) {
                print(e);
                SsNotification.error('Error al pagar la cuota');
              }
            },
          ),
        ],
      ),
    );
  }
}
