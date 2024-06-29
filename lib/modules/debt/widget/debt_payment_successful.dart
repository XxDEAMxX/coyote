import 'package:coyote/routes/app_router.dart';
import 'package:coyote/widgets/ss_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DebtPaymentSuccessful extends StatelessWidget {
  const DebtPaymentSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.4.sh,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.r),
              topRight: Radius.circular(14.r),
            ),
            child: Container(
              color: Colors.green,
              padding: EdgeInsets.symmetric(vertical: 5.h),
              width: double.infinity,
              child: Icon(
                Icons.done,
                color: Colors.greenAccent,
                size: 100.sp,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pago Registrado',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'El pago se registro con exito!',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SsButton(
                    text: 'Aceptar',
                    onTap: () async {
                      await appRouter.maybePop();
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
