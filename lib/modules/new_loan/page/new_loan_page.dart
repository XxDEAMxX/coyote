import 'package:auto_route/auto_route.dart';
import 'package:coyote/routes/app_router.dart';
import 'package:coyote/widgets/ss_app_bar.dart';
import 'package:coyote/widgets/ss_button.dart';
import 'package:coyote/widgets/ss_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class NewLoanPage extends StatelessWidget {
  const NewLoanPage({super.key});

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;
    return SsScaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Posición*',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: color,
                ),
              ),
              const SsTextInput(
                textColor: Colors.white,
                hintText: 'ej. 1',
              ),
              SizedBox(height: 20.h),
              Text(
                'Identificación Cliente*',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: color,
                ),
              ),
              const SsTextInput(
                textColor: Colors.white,
                hintText: 'ej. 1234567890',
              ),
              SizedBox(height: 20.h),
              Text(
                'Nombre Cliente*',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: color,
                ),
              ),
              const SsTextInput(
                textColor: Colors.white,
                hintText: 'ej. Juan Perez',
              ),
              SizedBox(height: 20.h),
              Text(
                'Dirección*',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: color,
                ),
              ),
              const SsTextInput(
                textColor: Colors.white,
                hintText: 'ej. Calle 123, colonia 1, CP 12345, CDMX',
              ),
              SizedBox(height: 20.h),
              Text(
                'Telefono*',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: color,
                ),
              ),
              const SsTextInput(
                textColor: Colors.white,
                hintText: 'ej. 3222222222',
              ),
              SizedBox(height: 20.h),
              Text(
                'Tipo Venta*',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: color,
                ),
              ),
              const SsTextInput(
                textColor: Colors.white,
                hintText: 'ej. Prestamo',
              ),
              SizedBox(height: 20.h),
              Text(
                'Valor Venta*',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: color,
                ),
              ),
              const SsTextInput(
                textColor: Colors.white,
                hintText: 'ej. 500.000',
              ),
              SizedBox(height: 20.h),
              Text(
                'Número Cuotas*',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: color,
                ),
              ),
              const SsTextInput(
                textColor: Colors.white,
                hintText: 'ej. 30',
              ),
              SizedBox(height: 20.h),
              SsButton(
                backgroundColor: Colors.green,
                textColor: Colors.black,
                width: double.infinity,
                text: 'Crear',
                onTap: () {
                  appRouter.maybePop();
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
      title: 'Nuevo Prestamo',
    );
  }
}
