import 'package:auto_route/auto_route.dart';
import 'package:coyote/data/client_database.dart';
import 'package:coyote/models/client_model.dart';
import 'package:coyote/modules/clients/clients_provider.dart';
import 'package:coyote/routes/app_router.dart';
import 'package:coyote/routes/app_router.gr.dart';
import 'package:coyote/widgets/ss_scaffold.dart';
import 'package:coyote/widgets/ss_button.dart';
import 'package:coyote/widgets/ss_notification.dart';
import 'package:coyote/widgets/ss_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class ClientNewPage extends ConsumerStatefulWidget {
  const ClientNewPage({super.key});

  @override
  ConsumerState<ClientNewPage> createState() => _ClientNewPageState();
}

class _ClientNewPageState extends ConsumerState<ClientNewPage> {
  bool loading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    const color = Colors.black;
    return SsScaffold(
      onBack: () {
        appRouter.back();
      },
      body: Container(
        color: color,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nombre*',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ),
              SsTextInput(
                controller: nameController,
                textColor: Colors.white,
                hintText: 'ej. Juan Perez',
                onChanged: (p0) {
                  setState(() {});
                },
              ),
              SizedBox(height: 20.h),
              Text(
                'Direccion*',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ),
              SsTextInput(
                controller: addressController,
                textColor: Colors.white,
                hintText: 'ej. cll 26 #12-56.',
                onChanged: (p0) {
                  setState(() {});
                },
              ),
              SizedBox(height: 20.h),
              Text(
                'Numero de telefono*',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.white,
                ),
              ),
              SsTextInput(
                keyboardType: TextInputType.number,
                controller: phoneController,
                textColor: Colors.white,
                hintText: 'ej. 3202222222',
                onChanged: (p0) {
                  setState(() {});
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  LengthLimitingTextInputFormatter(10),
                ],
              ),
              SizedBox(height: 20.h),
              SsButton(
                enable: loading == false &&
                    nameController.text.isNotEmpty &&
                    addressController.text.isNotEmpty &&
                    phoneController.text.isNotEmpty,
                loading: loading,
                backgroundColor: Colors.green,
                textColor: Colors.black,
                width: double.infinity,
                text: 'Crear',
                onTap: () async {
                  await addClient(
                    name: nameController.text,
                    address: addressController.text,
                    phone: phoneController.text,
                    ref: ref,
                  );
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addClient({
    required String name,
    required String address,
    required String phone,
    required WidgetRef ref,
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
      await ClientDatabase.instance.insert(clientModel);
      await ref.read(clientsProvider.notifier).getClients();
      appRouter.maybePop();
    } catch (e) {
      print(e);
    } finally {
      loading = false;
      setState(() {});
    }
  }
}
