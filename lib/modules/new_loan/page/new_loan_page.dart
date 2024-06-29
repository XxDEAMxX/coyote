import 'package:auto_route/auto_route.dart';
import 'package:coyote/data/client_database.dart';
import 'package:coyote/data/loan_database.dart';
import 'package:coyote/models/client_model.dart';
import 'package:coyote/models/loan_model.dart';
import 'package:coyote/modules/new_loan/loan_provider.dart';
import 'package:coyote/routes/app_router.dart';
import 'package:coyote/widgets/ss_app_bar.dart';
import 'package:coyote/widgets/ss_button.dart';
import 'package:coyote/widgets/ss_notification.dart';
import 'package:coyote/widgets/ss_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class NewLoanPage extends ConsumerStatefulWidget {
  const NewLoanPage({super.key});

  @override
  ConsumerState<NewLoanPage> createState() => _NewLoanPageState();
}

class _NewLoanPageState extends ConsumerState<NewLoanPage> {
  bool loading = false;
  final TextEditingController positionController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController quotasController = TextEditingController();

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
              SsTextInput(
                controller: positionController,
                textColor: Colors.white,
                hintText: 'ej. 1',
              ),
              // SizedBox(height: 20.h),
              // Text(
              //   'Identificación Cliente*',
              //   style: TextStyle(
              //     fontSize: 20.sp,
              //     color: color,
              //   ),
              // ),
              // const SsTextInput(
              //   textColor: Colors.white,
              //   hintText: 'ej. 1234567890',
              // ),
              SizedBox(height: 20.h),
              Text(
                'Nombre Cliente*',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: color,
                ),
              ),
              SsTextInput(
                controller: nameController,
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
              SsTextInput(
                controller: addressController,
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
              SsTextInput(
                controller: phoneController,
                textColor: Colors.white,
                hintText: 'ej. 3222222222',
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  LengthLimitingTextInputFormatter(10),
                ],
              ),
              // SizedBox(height: 20.h),
              // Text(
              //   'Tipo Venta*',
              //   style: TextStyle(
              //     fontSize: 20.sp,
              //     color: color,
              //   ),
              // ),
              // const SsTextInput(
              //   textColor: Colors.white,
              //   hintText: 'ej. Prestamo',
              // ),
              SizedBox(height: 20.h),
              Text(
                'Valor Venta*',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: color,
                ),
              ),
              SsTextInput(
                controller: amountController,
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
              SsTextInput(
                controller: quotasController,
                textColor: Colors.white,
                hintText: 'ej. 30',
              ),
              SizedBox(height: 20.h),
              SsButton(
                enable: _enable(),
                loading: loading,
                backgroundColor: Colors.green,
                textColor: Colors.black,
                width: double.infinity,
                text: 'Crear',
                onTap: () async {
                  await addLoan(
                    address: addressController.text,
                    amount: double.parse(amountController.text),
                    name: nameController.text,
                    phone: phoneController.text,
                    position: int.parse(positionController.text),
                    quotas: int.parse(quotasController.text),
                    ref: ref,
                  );
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

  bool _enable() {
    return nameController.text.isNotEmpty &&
        addressController.text.isNotEmpty &&
        phoneController.text.isNotEmpty &&
        positionController.text.isNotEmpty &&
        amountController.text.isNotEmpty &&
        quotasController.text.isNotEmpty;
  }

  Future<void> getClients() async {
    try {
      loading = true;
      setState(() {});
      await ref.read(loanProvider.notifier).getAllLoans();
    } catch (e) {
      print(e);
    } finally {
      loading = false;
      setState(() {});
    }
  }

  Future<void> addLoan({
    required String name,
    required String address,
    required String phone,
    required WidgetRef ref,
    required int position,
    required int quotas,
    required double amount,
  }) async {
    if (phone.length != 10 || phone.characters.first != '3') {
      SsNotification.warning('Numero de telefono no valido');
      return;
    }
    loading = true;
    setState(() {});
    final ClientModel clientModel = ClientModel(
      name: name,
      address: address,
      phoneNumber: phone,
    );

    try {
      final userId = await ClientDatabase.instance.insert(clientModel);
      final LoanModel loanModel = LoanModel(
        amount: amount,
        position: position,
        userId: '$userId',
        quotas: quotas,
      );
      await LoanDatabase.instance.insert(loanModel);
      await ref.read(loanProvider.notifier).getAllLoans();
      appRouter.maybePop();
    } catch (e) {
      print('Error create loan: $e');
    } finally {
      loading = false;
      setState(() {});
    }
  }
}
