import 'package:auto_route/auto_route.dart';
import 'package:coyote/data/client_database.dart';
import 'package:coyote/data/loan_database.dart';
import 'package:coyote/data/payments_database.dart';
import 'package:coyote/models/client_model.dart';
import 'package:coyote/models/loan_model.dart';
import 'package:coyote/models/payment_model.dart';
import 'package:coyote/modules/new_loan/loan_provider.dart';
import 'package:coyote/routes/app_router.dart';
import 'package:coyote/widgets/ss_app_bar.dart';
import 'package:coyote/widgets/ss_button.dart';
import 'package:coyote/widgets/ss_dropdown.dart';
import 'package:coyote/widgets/ss_notification.dart';
import 'package:coyote/widgets/ss_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class NewLoanPage extends ConsumerStatefulWidget {
  final ClientModel? client;

  const NewLoanPage({super.key, this.client});

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
  String? workDays;

  @override
  void initState() {
    super.initState();
    if (widget.client != null) {
      nameController.text = widget.client?.name ?? '-';
      addressController.text = widget.client?.address ?? '-';
      phoneController.text = widget.client?.phoneNumber ?? '-';
    }
  }

  @override
  Widget build(BuildContext context) {
    const color = Colors.black;
    final String title =
        widget.client == null ? 'Nueva Prestamo' : 'Editar Prestamo';
    return SsScaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
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
                  textColor: color,
                  hintText: 'ej. 1',
                  onChanged: (value) {
                    setState(() {});
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20.h),
                Text(
                  'Nombre Cliente*',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: color,
                  ),
                ),
                SsTextInput(
                  enable: widget.client == null,
                  controller: nameController,
                  textColor: color,
                  hintText: 'ej. Juan Perez',
                  onChanged: (value) {
                    setState(() {});
                  },
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
                  enable: widget.client == null,
                  controller: addressController,
                  textColor: color,
                  hintText: 'ej. Calle 123, colonia 1, CP 12345, CDMX',
                  onChanged: (value) {
                    setState(() {});
                  },
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
                  enable: widget.client == null,
                  controller: phoneController,
                  textColor: color,
                  hintText: 'ej. 3222222222',
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    LengthLimitingTextInputFormatter(10),
                  ],
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
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
                  textColor: color,
                  hintText: 'ej. 500',
                  onChanged: (value) {
                    setState(() {});
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
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
                  textColor: color,
                  hintText: 'ej. 30',
                  onChanged: (value) {
                    setState(() {});
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20.h),
                Text(
                  'Dias a cobrar*',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: color,
                  ),
                ),
                SsDropdown(
                  hint: 'ej. Lunes a Domingo',
                  onChanged: (value) {
                    workDays = value;
                    setState(() {});
                  },
                  options: [
                    'Lunes a Viernes',
                    'Lunes a Sabados',
                    'Lunes a Domingo',
                  ],
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
        quotasController.text.isNotEmpty &&
        workDays != null;
  }

  Future<void> getClients() async {
    try {
      loading = true;
      setState(() {});
      await ref.read(loanProvider.notifier).getAllLoans();
    } catch (e) {
      print(e);
      SsNotification.error('Error al obtener los clientes');
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
    if (workDays == null) {
      SsNotification.warning('Selecciona los dias de trabajo');
      return;
    }

    loading = true;
    setState(() {});

    try {
      int? clientId;
      if (widget.client == null) {
        final ClientModel clientModel = ClientModel(
          name: name,
          address: address,
          phoneNumber: phone,
        );
        clientId = await ClientDatabase.instance.insert(clientModel);
      }
      final amountTotal = amount + (amount * 0.2);
      final LoanModel loanModel = LoanModel(
        amount: amountTotal * 1000,
        position: position,
        clientId: widget.client != null ? widget.client!.id! : clientId,
        quotas: quotas,
        createAt: DateTime.now(),
        workDays: workDays!,
      );
      final loanId = await LoanDatabase.instance.insert(loanModel);
      final PaymentModel paymentModel = PaymentModel(
        loanId: loanId,
        amountPaid: 0.0,
        amountToBePaid: amountTotal / quotas * 1000,
        datePayment: DateTime.now(),
        quotaNumber: 1,
        updatedAt: null,
      );
      await PaymentsDatabase.instance
          .insertAll(paymentModel, quotas, workDays!);
      await ref.read(loanProvider.notifier).getAllLoans();
      appRouter.maybePop();
    } catch (e) {
      print(e);
      SsNotification.error('Error al crear el prestamo');
    } finally {
      loading = false;
      setState(() {});
    }
  }
}
