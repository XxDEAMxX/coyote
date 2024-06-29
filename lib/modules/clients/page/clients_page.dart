import 'package:auto_route/auto_route.dart';
import 'package:coyote/data/client_database.dart';
import 'package:coyote/models/client_model.dart';
import 'package:coyote/modules/clients/clients_provider.dart';
import 'package:coyote/modules/clients/widgets/clients_card.dart';
import 'package:coyote/routes/app_router.gr.dart';
import 'package:coyote/widgets/ss_app_bar.dart';
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
    return SsScaffold(
      title: 'Clientes',
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
                      const SsTextInput(
                        hintText: 'Buscar Cliente',
                      ),
                      SizedBox(height: 1.h),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 4.h),
                              child: ClientsCard(
                                client: list[index],
                              ),
                            );
                          },
                          itemCount: list.length,
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
