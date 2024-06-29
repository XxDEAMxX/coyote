import 'package:coyote/modules/debt/widget/debt_payment_successful.dart';
import 'package:coyote/routes/app_router.dart';
import 'package:coyote/widgets/ss_button.dart';
import 'package:coyote/widgets/ss_dialog.dart';
import 'package:coyote/widgets/ss_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentDialog extends StatelessWidget {
  const PaymentDialog({super.key});

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
                  '1',
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
          ),
          SsButton(
            width: double.infinity,
            text: 'Pagar',
            onTap: () async {
              await appRouter.maybePop();
              SsDialog.show(
                context: context,
                content: const DebtPaymentSuccessful(),
              );
            },
          ),
        ],
      ),
    );
  }
}
