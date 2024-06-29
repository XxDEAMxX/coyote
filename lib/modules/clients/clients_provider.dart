import 'package:coyote/data/client_database.dart';
import 'package:coyote/modules/clients/clients_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientsNotifier extends StateNotifier<ClientState> {
  ClientsNotifier() : super(ClientState());

  Future<void> getClients() async {
    final list = await ClientDatabase.instance.getAllClients();
    state = state.copyWith(
      clients: list,
    );
  }
}

final clientsProvider =
    StateNotifierProvider<ClientsNotifier, ClientState>((ref) {
  return ClientsNotifier();
});
