import 'package:auto_route/auto_route.dart';
import 'package:coyote/modules/clients/clients_provider.dart';
import 'package:coyote/modules/clients/widgets/clients_card.dart';
import 'package:coyote/routes/app_router.dart';
import 'package:coyote/routes/app_router.gr.dart';
import 'package:coyote/widgets/ss_scaffold.dart';
import 'package:coyote/widgets/ss_text_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class ClientsPage extends ConsumerStatefulWidget {
  const ClientsPage({super.key});

  @override
  ConsumerState<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends ConsumerState<ClientsPage> {
  bool loading = false;

  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getClients();
    });
  }

  Future<void> getClients() async {
    try {
      loading = true;
      setState(() {});
      await ref.read(clientsProvider.notifier).getClients();
    } catch (e) {
      print(e);
    } finally {
      loading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final list = ref.watch(clientsProvider.select((value) => value.clients));
    final listTmp = list.where((element) {
      return nameController.text.isEmpty
          ? true
          : element.name!
              .toLowerCase()
              .contains(nameController.text.toLowerCase());
    }).toList();
    return SsScaffold(
      onBack: () {
        appRouter.popAndPush(HomeRoute());
      },
      actions: [
        IconButton(
          icon: Icon(
            Icons.add_circle_outline,
            size: 30.sp,
          ),
          onPressed: () {
            context.router.push(const ClientNewRoute());
          },
        ),
      ],
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : list.isEmpty
              ? const Center(child: Text('No hay clientes'))
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  child: Column(
                    children: [
                      SsTextInput(
                        controller: nameController,
                        hintText: 'Buscar Cliente',
                        onChanged: (p0) {
                          setState(() {});
                        },
                      ),
                      SizedBox(height: 1.h),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.h),
                              child: ClientsCard(
                                client: listTmp[index],
                              ),
                            );
                          },
                          itemCount: listTmp.length,
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
